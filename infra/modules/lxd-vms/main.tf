resource "lxd_instance" "instance" {
  name  = var.name
  image = "ubuntu:noble/amd64"
  type = "virtual-machine"
  config = {
    "user.user-data" = file("${path.module}/cloud-init.yaml")
    "boot.autostart" = true
  }

  limits = {
    cpu = var.cpu
    memory = var.memory
  }
}
