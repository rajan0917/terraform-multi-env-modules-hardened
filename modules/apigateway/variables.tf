variable "name" {
  type = string
}
variable "description" {
  type    = string
  default = ""
}
variable "authorization" {
  type    = string
  default = "NONE"
}
variable "tags" {
  type    = map(string)
  default = {}
}
