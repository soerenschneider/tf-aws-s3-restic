bucket_name = "soerenschneider-restic-prod"

repos = [
  { name = "jellyfin-sqlite" },
  { name = "jellyfin-data" },
  { name = "linkding-postgres" },
  { name = "linkding-data" },
  { name = "mealie-postgres" },
  { name = "mealie-pvc" },
  { name = "miniflux" },
  { name = "radicale" },
  {
    name = "taskwarrior-prod",
    additional_buckets = [
      {
        bucket_name = "soerenschneider-taskwarrior-prod"
        readonly    = false,
      }
    ]
  },
  { name = "vault-prod" },
  { name = "vaultwarden" }
]
