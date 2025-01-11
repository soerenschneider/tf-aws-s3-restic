variable "bucket_name" {
  type = string
}

variable "repos" {
  type = list(object({
    name                 = string,
    password_store_paths = optional(list(string))
  }))
}

variable "password_store_paths" {
  type        = list(string)
  default     = []
  description = "Password storage path"
}
