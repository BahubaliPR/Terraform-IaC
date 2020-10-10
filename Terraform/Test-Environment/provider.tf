# Configure the AWS Provider
provider "aws" {
  version      = "~> 3.0"  
  region       = "ap-south-1"
  access_key  = var.access_keys
  secret_key  = var.secret_keys
}
