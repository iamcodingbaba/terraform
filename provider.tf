terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.7.0"
    }
  }
    backend "s3" {
        bucket = "<mybucket-name>" #this bucket i should create manuualy so doesent get deleted with terraform destroy and versioning enabled
        key    = "state/terraform.tfstate"
        region = "us-east-1"
  }

}

provider "aws" {
  region= "us-east-1"
}
