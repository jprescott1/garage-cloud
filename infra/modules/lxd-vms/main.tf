resource "random_string" "suffix" {
  count  = var.instance_count
  length = 5
  upper  = false
  numeric = false
  special = false
}

resource "lxd_volume" "volume" {
  count         = var.instance_count
  name          = "vol-${random_string.suffix[count.index]}"
  pool          = var.pool_name
  content_type  = "filesystem"

  config = {
    "zfs.block_mode" = true
    size             = var.volume_size
  }
}

resource "lxd_instance" "instance" {
  count = var.instance_count

  name  = "${var.name_prefix}-${random_string.suffix[count.index]}"
  image = var.image

  device {
    name = "vol-${count.index}"
    type = "disk"
    properties = {
      path   = "/mnt/data"
      pool   = var.pool_name
      source = lxd_volume.volume[count.index].name
    }
  }
}

