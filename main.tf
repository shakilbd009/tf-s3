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
  lifecycle_id = local.lifecycle_id
  #enable_lifecycle = false # by default its set to true, uncomment it to change it
  #enable_policy = false # by default its set to true, uncomment it to change it
}
