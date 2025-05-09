terraform {
  backend "gcs" {
    bucket = "tofu-state-garage"
    prefix = "./tf-deploy-lxd"
  }
}

# module "control-plane" {
#   source         = "../modules/lxd-vms"
#   image          = "images:rockylinux/9"
#   instance_count = 1
#   name_prefix    = "control-plane"
#   cpu            = 4
#   memory         = "6GiB"
#   volume_size    = "80GiB"
# }

module "worker" {
  source         = "../modules/lxd-vms"
  instance_count = 3
  name_prefix    = "worker"
  cpu            = 4
  memory         = "6GiB"
  volume_size    = "80GiB"
}
