bucket_name = "soerenschneider-restic-prod"

repos = [
  {
    name = "vault-prod",
  },
  {
    name = "taskwarrior-prod",
    additional_buckets = [
      {
        bucket_name = "soerenschneider-taskwarrior-prod"
        readonly = false,
      }
    ]
  }
]
