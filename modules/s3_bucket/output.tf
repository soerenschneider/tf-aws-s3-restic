output "access_keys" {
  value = {
    for repo in var.repos :
    repo.name => {
      name                 = repo.name
      access_key           = aws_iam_access_key.user[repo.name].id
      secret_key           = aws_iam_access_key.user[repo.name].secret
      password_store_paths = repo.password_store_paths
    }
  }
}
