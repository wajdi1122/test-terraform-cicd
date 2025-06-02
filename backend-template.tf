terraform {
  backend "s3" {
    bucket = "mon-bucket-terraform"
    key    = "envs/${terraform.workspace}/terraform.tfstate"
    region = "eu-north-1"
  }
}

