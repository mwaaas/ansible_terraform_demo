variable "TABLE_NAME" {
  type = "string"
}

variable "DEFAULT_TAGS" {
  type = "map"
  default = {
    Classification    = "restricted"
    Environment       = "staging"
    Owner             = "sysdev"
    Status            = "active"
  }
}

variable "WRITE_CAPACITY" {
  type = number
}

variable "READ_CAPACITY" {
  type = number
}