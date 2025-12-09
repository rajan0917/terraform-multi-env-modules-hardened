variable "name" {
  type = string
}
variable "subnets" {
  type    = list(string)
  default = []
}
variable "security_groups" {
  type    = list(string)
  default = []
}
variable "vpc_id" {
  type    = string
  default = ""
}
variable "target_port" {
  type    = number
  default = 80
}
variable "target_protocol" {
  type    = string
  default = "HTTP"
}
variable "listener_port" {
  type    = number
  default = 80
}
variable "listener_protocol" {
  type    = string
  default = "HTTP"
}
variable "health_path" {
  type    = string
  default = "/"
}
variable "health_protocol" {
  type    = string
  default = "HTTP"
}
variable "health_matcher" {
  type    = string
  default = "200-399"
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "enable_access_logs" {
  type    = bool
  default = true
}
variable "create_access_log_bucket" {
  type    = bool
  default = false
}
variable "access_log_bucket_name" {
  type    = string
  default = ""
}
variable "access_log_bucket" {
  type    = string
  default = ""
}
variable "access_log_prefix" {
  type    = string
  default = "alb-logs/"
}
variable "unhealthy_threshold" {
  type    = number
  default = 1
}
variable "alarm_actions" {
  type    = list(string)
  default = []
}
