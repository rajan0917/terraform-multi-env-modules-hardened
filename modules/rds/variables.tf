variable "identifier" {
  type = string
}
variable "engine" {
  type    = string
  default = "postgres"
}
variable "engine_version" {
  type    = string
  default = "15"
}
variable "instance_class" {
  type    = string
  default = "db.t3.medium"
}
variable "allocated_storage" {
  type    = number
  default = 20
}
variable "username" {
  type = string
}
variable "password" {
  type      = string
  sensitive = true
}
variable "subnet_ids" {
  type    = list(string)
  default = []
}
variable "parameter_family" {
  type    = string
  default = "postgres15"
}
variable "multi_az" {
  type    = bool
  default = false
}
variable "skip_final_snapshot" {
  type    = bool
  default = true
}
variable "backup_retention" {
  type    = number
  default = 7
}
variable "cpu_alarm_threshold" {
  type    = number
  default = 70
}
variable "alarm_actions" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}
