module "event_table" {
  source         = "./tf_modules/dyanamodb"
  READ_CAPACITY  = "20"
  TABLE_NAME     = var.EVENT_TABLE_NAME
  WRITE_CAPACITY = "20"
}