terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Version récente d'AWS Provider
    }
  }
}

provider "aws" {
  region = "eu-north-1"  # Choisissez votre région (ex: eu-west-1)
}

# Création d'un bucket S3 avec un nom unique
resource "aws_s3_bucket" "test_bucket" {
  bucket = "my-test-bucket-${random_id.suffix.hex}"  # Nom unique
  force_destroy = true  # Permet la suppression facile du bucket même s'il contient des objets
}

# Génère un suffixe aléatoire pour le nom du bucket
resource "random_id" "suffix" {
  byte_length = 4
}

# Optionnel : Bloquer l'accès public par défaut
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.test_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Sortie du nom du bucket (utile pour les pipelines)
output "bucket_name" {
  value = aws_s3_bucket.test_bucket.bucket
}