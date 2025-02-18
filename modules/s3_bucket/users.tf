resource "aws_iam_user" "user" {
  #checkov:skip=CKV_AWS_273:IAM user needed
  for_each = { for repo in var.repos : repo.name => repo }
  name     = "s3-${each.key}"
  path     = "/system/tf/tf-aws-s3-backups/${var.env}/"
}

resource "aws_iam_access_key" "user" {
  for_each = { for repo in var.repos : repo.name => repo }
  user     = aws_iam_user.user[each.key].name
}

resource "aws_iam_user_policy" "bucket_access" {
  #checkov:skip=CKV_AWS_40:No need for groups/roles here
  for_each = { for repo in var.repos : repo.name => repo }
  name     = "s3_backup_repo_${var.bucket_name}"
  user     = aws_iam_user.user[each.key].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = flatten([
      [
        {
          Effect   = "Allow",
          Action   = ["s3:ListBucket", "s3:GetBucketLocation"],
          Resource = "arn:aws:s3:::${var.bucket_name}"
        },
        {
          Effect   = "Allow",
          Action   = ["s3:PutObject", "s3:GetObject", "s3:DeleteObject"],
          Resource = "arn:aws:s3:::${var.bucket_name}/${each.key}/*"
        }
      ],
      [
        for bucket in coalesce(each.value.additional_buckets, []) : [
        {
          Effect   = "Allow",
          Action   = ["s3:ListBucket", "s3:GetBucketLocation"],
          Resource = "arn:aws:s3:::${bucket.bucket_name}"
        },
        {
          Effect   = "Allow",
          Action   = concat([
            "s3:GetObject",
            ],
            bucket.readonly ? [] : [
            "s3:PutObject",
            "s3:DeleteObject"
            ]),
          Resource = [
            length(coalesce(bucket.paths, [])) == 0 ? "arn:aws:s3:::${bucket.bucket_name}/*" :  [ for path in bucket.paths : "arn:aws:s3:::${bucket.bucket_name}/${path}/*"]
          ]
        }
      ]
      ]
    ])
  })
}
