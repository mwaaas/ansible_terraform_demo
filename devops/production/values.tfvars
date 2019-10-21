FOO_TOPIC_NAME = "stag_foo_topic"
FOO_QUEUE_NAME = "stag_foo"

BAR_TOPIC_NAME = "stag_bar_topic"
BAR_QUEUE_NAME = "stag_bar"

EVENT_TABLE_NAME = "ansible_terraform_demo"

TERRAFORM_ROLE_ARN =  "arn:aws:iam::309952364818:role/cloudformation-to-terraform-role"


# Using actual aws endpoints
DYNAMODB_ENDPOINT = ""
SNS_ENDPOINT= ""
SQS_ENDPOINT= ""
STS_ENDPOINT= ""

DEFAULT_TAGS = {
  Classification    = "restricted"
  Environment       = "staging"
  Owner             = "mwaaas"
  Status            = "active"
}