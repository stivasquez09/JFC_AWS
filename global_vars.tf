variable "region" {
  description = "Aws region to use on deployments"
  default = "us-east-1"
  type = string
}

variable "nombre" {
    default = "JFC"
  
}

variable "environment" {
  description = "Environment name, example: DEV or PROD"
  default = "DEV"
  type = string
}

variable "vpc_cidr" {
  description = "A network address space needed to create the vpc"
  default = "10.10.0.0/16"
  type = string
}

variable "subnet_cidr" {
    type = list(string)
    default = ["192.168.1.0/24", "192.168.2.0/24"]
}
variable "az_numbers" {
  type = number
  default = 2
  description = "amount of availability zones"
}
