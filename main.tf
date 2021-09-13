terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.83.0"
    }
  }
}
provider "google" {
  credentials = file("./service-account.json")
  version     = "3.83.0"
  region      = var.region
  project     = var.project
}

module "cdn"{
 source = "./modules/cdn"
}



