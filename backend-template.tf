terraform {
  backend "s3" {
    bucket = "mon-bucket-terraform"
    key    = "envs/${WORKSPACE}/terraform.tfstate"
    region = "eu-north-1"
  }
}

