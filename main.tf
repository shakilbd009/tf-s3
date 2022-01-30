locals {
  region = "us-east-2"
  profile = "default"
  bucket_name = "my-test-bucket-for-module"
  lifecycle_id = "all-contents-for-lifecycle"
}


provider "aws" {
  region = local.region
  profile = local.profile
}

module "s3_module" {
  source = "./module/s3"
  bucket_name = local.bucket_name
  set_lifecycle = true
  lifecycle_id = local.lifecycle_id
  #enable_policy = false
}
