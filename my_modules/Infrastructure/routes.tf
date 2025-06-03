resource "aws_route_table" "public_route_table" {
  vpc_id     = aws_vpc.jfc_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.nombre}_public_routes"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = var.az_numbers
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
  depends_on     = [aws_route_table.public_route_table, aws_subnet.subnets]
}