locals {
  env                          = basename(abspath(path.module))
  password_store_paths_default = ["soeren.cloud/env/${local.env}/restic/%s/aws-credentials"]
}

module "s3_bucket" {
  source      = "../../modules/s3_bucket"
  env         = local.env
  bucket_name = var.bucket_name
  repos       = var.repos
}

module "vault" {
  for_each             = { for creds in module.s3_bucket.access_keys : creds.name => creds }
  source               = "../../modules/vault"
  access_keys          = nonsensitive(each.value)
  password_store_paths = coalescelist(each.value.password_store_paths, var.password_store_paths, local.password_store_paths_default)
  metadata             = {}
}
