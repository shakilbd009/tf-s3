variable bucket_name {
  type        = string
  description = "s3 bucket name"
}

variable env {
  type        = string
  default     = "dev"
  description = "environment name"
}

variable enable_lifecycle {
  type        = bool
  default     = true
  description = "enable lifecycle or disable"
}

variable lifecycle_id {
  type        = string
  description = "lifecycle_id"
}

variable enable_policy {
  type        = bool
  default     = true
  description = "enable bucket policy or not"
}



