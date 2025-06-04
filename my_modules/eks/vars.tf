variable "nombre" {}

variable "my_vpc_id" {
    description = "VPC ID"
}

variable "my_subnets" {
  description = "VPC ID"
}

variable "cluster_name" {
  type    = string
  default = "JFC-PROD-K8S"
}

variable "cluster_version" {
  type    = string
  default = "1.29"
}

variable "node_desired_capacity" {
  type    = number
  default = 2
}

variable "node_max_capacity" {
  type    = number
  default = 4
}

variable "node_min_capacity" {
  type    = number
  default = 1
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "alb_sg_id" {
  type = string
}

variable "port" {
  type    = number
  default = 8080
}

variable "tags" {
  type    = map(string)
  default = {
    Environment = "prod"
    Project     = "JFC"
  }
}
