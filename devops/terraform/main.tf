module "foo_topic" {
  source = "./tf_modules/sns"
  DEFAULT_TAGS = var.DEFAULT_TAGS
  TOPIC_NAME = var.FOO_TOPIC_NAME
}

module "foo_queue" {
  source = "./tf_modules/sqs"
  QUEUE_NAME = var.FOO_QUEUE_NAME
  TOPIC_ARN = var.FOO_TOPIC_NAME
  DEFAULT_TAGS = var.DEFAULT_TAGS
}

module "bar_topic" {
  source = "./tf_modules/sns"
  DEFAULT_TAGS = var.DEFAULT_TAGS
  TOPIC_NAME = var.BAR_TOPIC_NAME
}

module "bar_queue" {
  source = "./tf_modules/sqs"
  QUEUE_NAME = var.BAR_QUEUE_NAME
  TOPIC_ARN = var.BAR_TOPIC_NAME
  DEFAULT_TAGS = var.DEFAULT_TAGS
}

module "table" {
  source         = "./tf_modules/dyanamodb"
  READ_CAPACITY  = "20"
  TABLE_NAME     = var.TABLE_NAME
  WRITE_CAPACITY = "20"
}