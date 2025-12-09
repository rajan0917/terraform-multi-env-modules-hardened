variable "zone_name" {
  type = string
}
variable "comment" {
  type    = string
  default = ""
}
variable "force_destroy" {
  type    = bool
  default = false
}
variable "www_record" {
  type    = bool
  default = false
}
variable "www_records" {
  type    = list(string)
  default = []
}
variable "www_ttl" {
  type    = number
  default = 300
}
variable "tags" {
  type    = map(string)
  default = {}
}
