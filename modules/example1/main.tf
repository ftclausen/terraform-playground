module "sibling1_mod" {
  source = "../sibling1"
}

module "sibling2_mod" {
  source = "../sibling2"
}

variable "input1" {
}

variable "collection" {
  description = "A collection"
  default = ["something", "else"]
  type = list
}

variable "consul_keys_available" {
  type = list(map(string))
}

// or, for example, in kubernetes this is the "spec {}" block
data "consul_keys" "app" {
  // or, again for example, in k8s this is then the "spec { volumes {} }" blocks
  dynamic "key" {
    for_each = var.consul_keys_available
    content {
      name = key.value["name"]
      path = key.value["path"]
      default = key.value["default"]
    }
  }
}
