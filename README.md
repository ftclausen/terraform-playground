## What is this?

This is a contrived, minimal project loosely based on a production terraform repo in which I can play and learn without
risking breakage.

Base on [this repo used for some troubleshooting](https://github.com/ftclausen/tf12-mod-source-issue)

## Layout

The layout roughly replicas our internal repo minus some convenience wrapper for terragrunt to run over the multiple
accounts and projects:

```
.
├── README.md
├── accounts
│   ├── account1
│   │   ├── common.hcl
│   │   └── earth
│   │       └── dev
│   │           ├── common.hcl
│   │           └── service1
│   │               └── terragrunt.hcl
│   └── terragrunt.hcl
├── common
│   └── account1-dev-earth.tfvars
├── modules
│   ├── example1
│   │   ├── main.tf
│   │   └── terragrunt.hcl
│   ├── sibling1
│   │   ├── main.tf
│   │   └── terragrunt.hcl
│   └── sibling2
│       ├── main.tf
│       └── terragrunt.hcl
└── terragrunt.py
```
