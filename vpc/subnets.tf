locals {
  vpc_az       = ["a"]
  base_cidr    = cidrsubnets(var.vpc_cidr_block, 2, 2)
  sbn_public   = cidrsubnets(local.base_cidr[0], 2)
  sbn_private  = cidrsubnets(local.base_cidr[1], 2)
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  count = length(local.sbn_public)

  vpc_id                  = aws_vpc.main.id
  availability_zone_id    = element(data.aws_availability_zones.available.zone_ids, count.index)
  cidr_block              = element(concat(local.sbn_public, [""]), count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-public-a"
  }
}


resource "aws_subnet" "private" {
  count = length(local.sbn_private)

  vpc_id               = aws_vpc.main.id
  availability_zone_id = element(data.aws_availability_zones.available.zone_ids, count.index)
  cidr_block           = element(concat(local.sbn_private, [""]), count.index)

  tags = {
    Name = "subnet-private-a"
  }
}