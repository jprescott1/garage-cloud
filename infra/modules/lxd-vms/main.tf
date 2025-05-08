locals {
  instance_ids = toset([for i in range(var.var.instance_count) : i])
}

resource "random_string" "suffix" {
  for_each = local.instance_ids
  length   = 8
  special  = false
  lower    = true
}

resource "lxd_instance" "instance" {
  count = var.instance_count
  name  = "${var.name}${count.index + 1}-${random_string.suffix[count.index].result}"
  image = "ubuntu:noble/amd64"
  type  = "virtual-machine"
  config = {
    "user.user-data" = file("${path.module}/cloud-init.yaml")
    "boot.autostart" = true
  }

  limits = {
    cpu    = var.cpu
    memory = var.memory
  }
}
