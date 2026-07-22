terraform {
  required_version = ">= 1.14.0"

  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "~> 1.22.0"
    }
    cloudfoundry = {
      source  = "cloudfoundry/cloudfoundry"
      version = "~>1.15.0"
    }
    sci = {
      source  = "SAP/sap-cloud-identity-services"
      version = "0.7.0-beta1"
    }
  }
}
