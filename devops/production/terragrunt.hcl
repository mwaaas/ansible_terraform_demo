terraform {
  source = "../terraform"
}

inputs = {
  FOO_TOPIC_NAME = "prod_foo_topic"
  FOO_QUEUE_NAME = "prod_foo"

  BAR_TOPIC_NAME = "prod_bar_topic"
  BAR_QUEUE_NAME = "prod_bar"

  EVENT_TABLE_NAME = "prod_ansible_terraform_demo"

  TERRAFORM_ROLE_ARN =  "arn:aws:iam::354955808555:role/terraform"


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

  PROFILE = "mwaside"

}