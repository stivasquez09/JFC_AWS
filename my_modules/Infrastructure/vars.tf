variable "nombre"{}
variable "vpc_cidr" {}
variable "az_numbers" {}
variable "environment" {}
data "aws_availability_zones" "available" {
  state = "available"
}
variable "subnet_cidr" {}
