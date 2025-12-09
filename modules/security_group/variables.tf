variable "name" {
  type = string
}
variable "description" {
  type = string
  default = "managed-sg"
}
variable "vpc_id" {
  type = string
}
variable "tags" { type = map(string) default = {} }
variable "ingress" { type = list(any) default = [{ from_port=80, to_port=80, protocol="tcp", cidr_blocks=["0.0.0.0/0"] }] }
variable "egress" { type = list(any) default = [{ from_port=0, to_port=0, protocol="-1", cidr_blocks=["0.0.0.0/0"] }] }