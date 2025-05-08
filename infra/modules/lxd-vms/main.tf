locals {
  instance_ids = toset([for i in range(var.instance_count) : tostring(i)])
}

data "lxd_storage_pool" "pool" {
  name = "datapool"
}

resource "lxd_volume" "volume" {
  name = "data"
  pool = data.lxd_storage_pool.pool.name

  content_type = "filesystem"

  config = {
    "zfs.block_mode" = true
    size             = "80GiB"
  }
}

resource "random_string" "suffix" {
  for_each = local.instance_ids
  length   = 8
  special  = false
  upper    = false
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

  device {
    name = "data"
    type = "disk"
    properties = {
      path   = "/mnt/data"
      pool   = data.lxd_storage_pool.pool.name
      source = lxd_volume.volume.name
    }
  }
}
