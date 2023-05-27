variable "test" {
  default     = "test"
  type        = string
  description = "test"
}

output "test" {
  value = var.test
}
