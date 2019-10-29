
module "SnsFooV1" {
  source = "./tf_modules/sns"
  TOPIC_NAME = "foo_1"
  DEFAULT_TAGS = var.DEFAULT_TAGS
}


module "SnsBarV1" {
  source = "./tf_modules/sns"
  TOPIC_NAME = "bar_1"
  DEFAULT_TAGS = var.DEFAULT_TAGS
}

