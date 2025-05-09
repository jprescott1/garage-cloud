terraform {
  backend "gcs" {
    bucket = "tofu-state-garage"
    prefix = "./tf-deploy-lxd"
  }
}

module "worker" {
  source         = "../modules/lxd-vms"
  instance_count = 3
  name_prefix    = "worker"
  cpu            = 4
  memory         = "6GiB"
  volume_size    = "80GiB"
}
