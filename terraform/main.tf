
variable "branch" {
  type = string
}

variable "suffix" {
  type = string
}

variable "metadata_db" {
  type = object({
    db_name  = string
    username = string
    password = string
    port     = string
  })
  sensitive = true
}

variable "fernet_key" {
  type      = string
  sensitive = true
}

variable "gcp_region" {
  type    = string
  default = "us"
}

