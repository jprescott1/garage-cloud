terraform {
  backend "gcs" {
    bucket = "tofu-state-garage"
    prefix = "./tf-deploy-lxd"
  }
}

module "control-plane" {
  source         = "../modules/lxd-vms"
  instance_count = 1
  name           = "control-plane"
  cpu            = 4
  memory         = "6GiB"
  volume_name    = lxd_volume.data_volume.name
  storage_pool   = lxd_volume.data_volume.pool
}

module "worker" {
  source         = "../modules/lxd-vms"
  instance_count = 3
  name           = "worker"
  cpu            = 4
  memory         = "6GiB"
  volume_name    = lxd_volume.data_volume.name
  storage_pool   = lxd_volume.data_volume.pool
}
