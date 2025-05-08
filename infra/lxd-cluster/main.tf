terraform {
  backend "gcs" {
    bucket = "tofu-state-garage"
    prefix = "./tf-deploy-lxd"
  }
}

module "node1" {
    source = "../modules/lxd-vms"
    name = "vm-1"
    cpu = 1
    memory = "8GiB"
}
