bucket_name = "soerenschneider-restic-prod"

repos = [
  { name = "miniflux" },
  { name = "vault-prod" },
  { name = "vaultwarden" },
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
