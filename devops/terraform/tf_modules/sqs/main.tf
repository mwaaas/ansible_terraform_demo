data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_sqs_queue" "demo_deadletter" {
  name = "${var.QUEUE_NAME }_dl"
  tags = merge(var.DEFAULT_TAGS, map("Name", "${var.QUEUE_NAME }_dl"))
}

resource "aws_sqs_queue" "demo_sqs" {
  depends_on = [
    aws_sqs_queue.demo_deadletter
  ]
  name = var.QUEUE_NAME
  delay_seconds = var.DELAY_SECONDS
  max_message_size = var.MAXIMUM_MESSAGE_SIZE
  message_retention_seconds = var.MESSAGE_RETENTION_PERIOD
  receive_wait_time_seconds = var.RECEIVE_MESSAGE_WAIT_TIME_SECOND
  redrive_policy = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.demo_deadletter.arn}\",\"maxReceiveCount\":4}"
  visibility_timeout_seconds = var.VISIBILITY_TIMEOUT_SECONDS
  tags = merge(var.DEFAULT_TAGS, map("Name", var.QUEUE_NAME))
}

resource "aws_sns_topic_subscription" "demo_topic_subscription" {
  depends_on = [
    aws_sqs_queue.demo_sqs
  ]
  endpoint = aws_sqs_queue.demo_sqs.arn
  protocol = "sqs"
  topic_arn = "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.TOPIC_ARN}"
  raw_message_delivery = false
}
