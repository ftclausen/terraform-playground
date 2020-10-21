include {
  path = "${find_in_parent_folders()}"
}

terraform {
  source = "../../../../..//modules/example1"
}

inputs = {
  input1 = "something"
  consul_keys_available = [
    {
      name = "key1"
      path = "/service/app/key1"
      default = "1"
    },
    {
      name = "key2"
      path = "/service/app/key2"
      default = "2"
    }
  ]
}
