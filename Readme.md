# Eks-hosted Github Action Runner

## About
This repo is for setting a self-hosted Github Action Runner system on Eks. Karpenter is used for auto scaling because it's more flexible in selecting appropriate node types. The whole infrastructure is managed by terraform for safety and repeatability.
## Getting Started
### 1. set up environments
- set aws environment variables
```shell
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-west-2
```
- Generate a Personal Access Token (PAT) for ARC to authenticate with GitHub.

 1.  Login to your GitHub account and Navigate to "[Create new Token](https://github.com/settings/tokens/new)."
 2.  Select  **repo**.
 3. Click **Generate Token** and then copy the token.

- Set the value of pat_token
```shell
variable "pat_token" {
  type        = string
  default     = "Your pat token"
  description = "The pat token of you github account"
}
```
Note that for safety reasons, it's not recommended hardcode the token in the code. You can use terraform variable or use terraform.tfvars to save the token.

- Deploy eks-hosted ghar
Install all providers
```shell
terraform init
```
Apply the ghar
```shell
terraform apply
```
## Reference
[Github action runner](https://github.com/actions/actions-runner-controller/blob/master/docs/quickstart.md)

[Set eks cluster with Karpenter enabled](https://github.com/antonputra/tutorials/tree/main/lessons/114)
