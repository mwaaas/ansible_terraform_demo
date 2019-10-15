resource "aws_sns_topic" "demo-topic" {
  name = var.TOPIC_NAME
  tags = merge(var.DEFAULT_TAGS, map("Name", var.TOPIC_NAME))
}