provider "aws" {
  region  = "eu-west-1"
  version = "~> 2.31"
  profile = var.AWS_PROFILE
  endpoints {
    dynamodb = var.AWS_DYNAMODB_ENDPOINT
    sqs      = var.AWS_SQS_ENDPOINT
    sns      = var.AWS_SNS_ENDPOINT
    sts      = var.AWS_STS_ENDPOINT
  }
  assume_role {
    role_arn = var.TERRAFORM_ROLE_ARN
  }
}