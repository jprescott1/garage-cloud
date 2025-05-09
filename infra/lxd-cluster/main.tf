terraform {
  backend "gcs" {
    bucket = "tofu-state-garage"
    prefix = "./tf-deploy-lxd"
  }
}


module "control-plane" {
  source         = "../modules/lxd-vms"
  instance_count = 1
  name_prefix    = "control-plane"
  cpu            = 4
  memory         = "6GiB"
}

