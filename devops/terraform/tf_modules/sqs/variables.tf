variable "QUEUE_NAME" {
  type = string
}

variable "DELAY_SECONDS" {
  type = string
  default = 5
}

variable "MAXIMUM_MESSAGE_SIZE" {
  type = string
  default = 262144
}

variable "MESSAGE_RETENTION_PERIOD" {
  type = string
  default = 345600
}

variable "RECEIVE_MESSAGE_WAIT_TIME_SECOND" {
  type = string
  default = 1
}

variable "VISIBILITY_TIMEOUT_SECONDS" {
  type = string
  default = 5
}

variable "TOPIC_ARN" {
  type = string
}

variable "DEFAULT_TAGS" {
  type = "map"
}