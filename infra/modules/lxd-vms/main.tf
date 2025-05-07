resource "lxd_instance" "instance" {
  name  = "node-name"
  image = "ubuntu:noble/amd64"
  type = "virtual-machine"
  config = {
    "user.user-data" = file("${path.module}/cloud-init.yaml")
    "boot.autostart" = true
  }

  limits = {
    cpu = 2
    memory = "4GiB"
  }
}
