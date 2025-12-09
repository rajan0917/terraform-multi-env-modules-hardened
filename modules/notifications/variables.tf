variable "name" {
  type    = string
  default = "alerts"
}
variable "email" {
  type    = string
  default = ""
}
variable "sms_numbers" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}
