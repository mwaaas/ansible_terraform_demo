provider "aws" {
  region  = "eu-west-1"
  version = "~> 2.31"
  endpoints {
    dynamodb = var.DYNAMODB_ENDPOINT
    sqs      = var.SQS_ENDPOINT
    sns      = var.SNS_ENDPOINT
    sts      = var.STS_ENDPOINT
  }
  assume_role {
    role_arn = var.TERRAFORM_ROLE_ARN
  }
}