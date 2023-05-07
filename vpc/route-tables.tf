// Route Tables

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rtb-public-a"
  }
}

resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public.*.id)
    subnet_id      = element(aws_subnet.public, count.index).id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id
  }

  tags = {
    Name = "rtb-private-a"
  }
}

resource "aws_route_table_association" "private" {
    count = length(aws_subnet.private.*.id)
    subnet_id      = element(aws_subnet.private, count.index).id
    route_table_id = aws_route_table.private.id
}
