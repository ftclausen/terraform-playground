locals {
  terraform_version = "0.13.6"
  minimum_terragrunt_version = "0.23"

  account_vars = read_terragrunt_config("${get_parent_terragrunt_dir()}/${get_env("ACCOUNT", "")}/common.hcl", {inputs = {}})
  environment_vars = read_terragrunt_config(
    "${get_parent_terragrunt_dir()}/${get_env("ACCOUNT", "")}/${get_env("REGION", "")}/${get_env("ENVIRONMENT", "")}/common.hcl",
    {inputs = {}}
  )

  env = split("-", get_env("ENVIRONMENT", ""))[0]

  // Strip off the account from the microservice path, for backwards compat
  state_path = join("/", slice(split("/", path_relative_to_include()), 1, 4))

  env_long_name_map = {
    ci          = "continuous-integration"
    dev         = "development"
    prod        = "production"
    stage       = "stage"
    test        = "test"
  }
}

inputs = merge(local.account_vars.inputs, local.environment_vars.inputs, {
  env           = local.env
  region        = get_env("REGION", "")
})

terraform_version_constraint = "= ${local.terraform_version}"
terragrunt_version_constraint = ">= ${local.minimum_terragrunt_version}"

// We can define
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_version = "= ${local.terraform_version}"
}
EOF
}

terraform {
  after_hook "after_hook" {
    commands = [
      "apply",
      "plan",
      "destroy",
    ]

    execute = [
      "rm",
      "-f",
      "${get_terragrunt_dir()}/provider.tf"
    ]
    run_on_error = true
  }
}
