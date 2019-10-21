variable "FOO_TOPIC_NAME" {
  type = string
}

variable "FOO_QUEUE_NAME" {
  type = string
}

variable "BAR_TOPIC_NAME" {
  type = string
}

variable "BAR_QUEUE_NAME" {
  type = string
}

variable "EVENT_TABLE_NAME" {
  type = string
}

variable "TERRAFORM_ROLE_ARN" {
  type = string
}

variable "DYNAMODB_ENDPOINT" {
  type = string
}

variable "SQS_ENDPOINT" {
  type = string
}

variable "SNS_ENDPOINT" {
  type = string
}

variable "STS_ENDPOINT" {
  type = string
}

variable "DEFAULT_TAGS" {
  type = "map"
}