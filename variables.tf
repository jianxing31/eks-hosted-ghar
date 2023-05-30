variable "cluster_name" {
  type        = string
  default     = "ghar_test"
  description = "eks cluster name"
}

variable "pat_token" {
  type        = string
  default     = "Your pat token"
  description = "The pat token of you github account"
}

variable "target_repo" {
  type        = string
  default     = "your_target_repo_name, e.g. jianxing31/eks-hosted-ghar"
  description = "Your target repo that use the action runner"
}
