terraform {
  backend "gcs" {
    bucket = "tofu-state-garage"
    prefix = "./tf-deploy-do-k8s"
  }
}

module "do-droplet" {
  source         = "../../../modules/do-k8s"
}
