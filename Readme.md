# Eks-hosted Github Action Runner

## About
This repo is for setting a self-hosted Github Action Runner system on Eks. Karpenter is used for auto scaling because it's more flexible in selecting appropriate node types. The whole infrastructure is managed by terraform for safety and repeatability.
![architect.png](https://github.com/jianxing31/eks-hosted-ghar/blob/main/images/architect.png)
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

- Set the value of your target repo
```shell
variable "target_repo" {
  type        = string
  default     = "your_target_repo_name, e.g. jianxing31/eks-hosted-ghar"
  description = "Your target repo that use the action runner"
}
```
Note that for safety reasons, it's not recommended hardcode the token in the code. You can use terraform variable or use terraform.tfvars to save the token.

### 2. Deploy EKS-hosted ghar cluster

- Install all providers
```shell
terraform init
```
- Apply the ghar
```shell
terraform apply
```

### 3. Check cluster status

- Connect to eks cluster
```shell
aws eks --region us-east-1 update-kubeconfig --name ghar_test
```
- Check cluster status with kubectl   
Example:
```shell
kubectl get pods -A
```

### 4. Use action runner in your repo

- Create a workflow to use the runner   
Example workflow:
```shell
name: lint
on:
  - pull_request

jobs:
  lint:
    runs-on: test-runner # Your runenr name
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - uses: hashicorp/setup-terraform@v1
        with:
          terraform_version: 1.0.0
      - uses: pre-commit/action@v2.0.2
        with:
          extra_args: --all-files --show-diff-on-failure
```


<!-- BEGIN_TF_DOCS --> 
<!-- END_TF_DOCS -->

## Reference
[Github action runner](https://github.com/actions/actions-runner-controller/blob/master/docs/quickstart.md)

[Set eks cluster with Karpenter enabled](https://github.com/antonputra/tutorials/tree/main/lessons/114)
