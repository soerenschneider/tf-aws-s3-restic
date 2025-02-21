bucket_name = "soerenschneider-restic-prod"

repos = [
  { name = "vault-prod" },
  { name = "radicale" },
  {
    name = "taskwarrior-prod",
    additional_buckets = [
      {
        bucket_name = "soerenschneider-taskwarrior-prod"
        readonly    = false,
      }
    ]
  }
]
