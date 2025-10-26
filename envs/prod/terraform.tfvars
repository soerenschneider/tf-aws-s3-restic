bucket_name = "soerenschneider-restic-prod"

repos = [
  {
    name = "auth-mariadb",
    password_store_paths = [
      "machine-group/auth/restic/%s/aws-credentials",
    ],
  },
  { name = "jellyfin" },
  { name = "linkding" },
  { name = "mealie" },
  { name = "memos" },
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
