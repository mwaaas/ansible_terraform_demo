FOO_TOPIC_NAME = "dev_foo_topic"
FOO_QUEUE_NAME = "dev_foo"

BAR_TOPIC_NAME = "dev_bar_topic"
BAR_QUEUE_NAME = "dev_bar"

TABLE_NAME = "ansible_terraform_demo"

TERRAFORM_ROLE_ARN =  "arn:aws:iam::309952364818:role/eng-recce-cloudformation-role"


DYNAMODB_ENDPOINT = "http://dynamodb:8000"

SNS_ENDPOINT = "http://localaws:4100"

SQS_ENDPOINT = "http://localaws:4100"

DEFAULT_TAGS = {
  Classification    = "restricted"
  Environment       = "staging"
  Owner             = "mwaaas"
  Status            = "active"
}