terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>6.21"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
  required_version = "~> 1.9"
}
