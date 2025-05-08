locals {
  instance_ids = toset([for i in range(var.instance_count) : tostring(i)])
}

resource "lxd_storage_pool" "pool" {
  name   = "datapool"
  driver = "zfs"
}

resource "lxd_volume" "volume" {
  name = "data"
  pool = lxd_storage_pool.pool.name

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

  device {
    name = "data"
    type = "disk"
    properties = {
      path = "/mnt/data"
      pool = lxd_storage_pool.pool.name
      pool = lxd_volume.volume.name
    }
  }
}
