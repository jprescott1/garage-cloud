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
}

module "worker" {
  source         = "../modules/lxd-vms"
  instance_count = 3
  name           = "worker"
  cpu            = 4
  memory         = "6GiB"
}
