variable "AWS_PROFILE" {
  type = string
}


variable "EVENT_TABLE_NAME" {
  type = string
}

variable "TERRAFORM_ROLE_ARN" {
  type = string
}

variable "AWS_DYNAMODB_ENDPOINT" {
  type = string
}

variable "AWS_SQS_ENDPOINT" {
  type = string
}

variable "AWS_SNS_ENDPOINT" {
  type = string
}

variable "AWS_STS_ENDPOINT" {
  type = string
}

variable "DEFAULT_TAGS" {
  type = "map"
}