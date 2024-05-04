terraform {
  cloud {
    hostname = "app.terraform.io"
    organization = "HYTKY"

    workspaces {
      name = "do-tofu-test"
    }
  }
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
}