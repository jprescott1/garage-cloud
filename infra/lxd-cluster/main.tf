terraform {
  backend "gcs" {
    bucket = "tofu-state-garage"
    prefix = "./tf-deploy-lxd"
  }
}

# module "control-plane" {
#   source = "../modules/lxd-vms"
#   count  = 2
#   name   = "control-plane"
#   cpu    = 4
#   memory = "6GiB"
# }
