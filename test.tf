terraform {
  required_version = "~> 1.0"
}

variable "test" {
  default     = "test"
  type        = string
  description = "test"
}

output "test" {
  value = var.test
}
