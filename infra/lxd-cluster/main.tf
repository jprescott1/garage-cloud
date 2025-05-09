terraform {
  backend "gcs" {
    bucket = "tofu-state-garage"
    prefix = "./tf-deploy-lxd"
  }
}
