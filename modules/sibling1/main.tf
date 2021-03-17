data "docker_registry_image" "debian" {
  name = "debian:stable-slim"
}

data "docker_registry_image" "alpine" {
  name = "alpine:3.12.0"
}

resource "docker_image" "debian" {
  name = data.docker_registry_image.debian.name
  pull_triggers = [data.docker_registry_image.debian.sha256_digest]
}

resource "docker_container" "fred" {
  for_each = {
    container1 = "fred1"
    container2 = "fred2"
  }
  name = each.key
  image = data.docker_registry_image.debian.name
}
