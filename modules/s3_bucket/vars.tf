variable "env" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "repos" {
  type = list(object({
    name                 = string,
    password_store_paths = optional(list(string))
    additional_buckets   = optional(list(object({
      bucket_name = string,
      readonly = bool,
      paths = optional(list(string))
    })))
  }))
}
