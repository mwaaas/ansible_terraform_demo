FOO_TOPIC_NAME = "dev_foo_topic"
FOO_QUEUE_NAME = "dev_foo"

BAR_TOPIC_NAME = "dev_bar_topic"
BAR_QUEUE_NAME = "dev_bar"

EVENT_TABLE_NAME = "ansible_terraform_demo"

TERRAFORM_ROLE_ARN =  "arn:aws:iam::309952364818:role/cloudformation-to-terraform-role"


DYNAMODB_ENDPOINT = "http://dynamodb-local-mock-unsupported-api:4567"

SNS_ENDPOINT= "http://localaws:4575"

SQS_ENDPOINT= "http://localaws:4576"

STS_ENDPOINT= "http://localaws:4592"

DEFAULT_TAGS = {
  Classification    = "restricted"
  Environment       = "staging"
  Owner             = "mwaaas"
  Status            = "active"
}