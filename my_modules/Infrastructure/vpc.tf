## Create a VPC
resource "aws_vpc" "jfc_vpc" {

  enable_dns_hostnames             = true
  enable_dns_support               = true
  cidr_block                       = var.vpc_cidr ## Static CIDR
  assign_generated_ipv6_cidr_block = false
  tags = {
    Name = "${var.nombre}_vpc"
  }

  ## Prevent to destroy
  lifecycle {
    prevent_destroy = false
  }
}

# resource "aws_subnet" "jfc_public" {
#   #   depends_on = [ aws_vpc.main ]
#   count                   = var.az_numbers ## Number of subnets
#   vpc_id                  = aws_vpc.jfc_vpc.id
#   availability_zone       = data.aws_availability_zones.available.names[count.index]
#   cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index) ## Dynamic Subnet CIDR from a VPC main CIDR example: 10.10.0.0/24
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${var.environment}_public_net_${count.index + 1}"
#     Type = "public"
#   }
# }

#subnet creation
resource "aws_subnet" "subnets" {
  count                   = var.az_numbers
  vpc_id                  = aws_vpc.jfc_vpc.id
  cidr_block              = element(var.subnet_cidr, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true


  tags = {
    Name = "${var.nombre}_Subnet_Public${count.index + 1}"
  }
}

resource "aws_eip" "public_ip" {
  domain = "vpc"
  tags = {
    Name = "${var.environment}_eip"
  }
}

#internet gatawey creation
# vpc_id = aws_vpc.main.id validar esta forma de llamada 
resource "aws_internet_gateway" "gw" {
  depends_on = [aws_eip.public_ip]
  vpc_id     = aws_vpc.jfc_vpc.id
  tags = {
    Name = "Gateway_${var.nombre}_VPC"
  }
}
