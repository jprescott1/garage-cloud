terraform {
  backend "gcs" {
    bucket = "tofu-state-garage"
    prefix = "./tf-deploy-lxd"
  }
}

resource "lxd_volume" "data_volume" {
  name = "data"
  pool = "datapool"

  content_type = "filesystem"

  config = {
    "zfs.block_mode" = true
    size             = "80GiB"
  }

  lifecycle {
    prevent_destroy = true
  }
}

module "control-plane" {
  source         = "../modules/lxd-vms"
  instance_count = 1
  name           = "control-plane"
  cpu            = 4
  memory         = "6GiB"
}

module "worker" {
  source         = "../modules/lxd-vms"
  instance_count = 3
  name           = "worker"
  cpu            = 4
  memory         = "6GiB"
}
