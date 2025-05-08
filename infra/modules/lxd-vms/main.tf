locals {
  instance_ids = toset([for i in range(var.instance_count) : tostring(i)])
}

resource "lxd_storage_pool" "virtual_pool" {
  name   = "clusterpool"
  driver = "lvm"
  config = {
    "lvm.vg_name" = "data"
    "size"        = "500GiB"
  }
}

resource "lxd_volume" "volume" {
  name         = "vm-volume"
  pool         = lxd_storage_pool.virtual_pool.name
  content_type = "filesystem"
  config = {
    size        = "80GiB"
    lvm.vg_name = "vm-data"
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
      path   = "/mnt/data"
      size   = "80GiB"
      source = lxd_volume.volume.name
      pool   = lxd_storage_pool.name
    }
  }
}
