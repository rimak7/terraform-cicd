terraform {
  backend "s3" {
    bucket       = "my-backend-cicd-terraform"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
