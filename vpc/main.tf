// VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "fist-vpc"
  }
}

// Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "fist-vpc"
  }
}

// NAT Gateway
resource "aws_eip" "nat" {
  vpc      = true

  tags = {
    Name = "fist-vpc"
  }
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "fist-vpc"
  }
}

resource "aws_vpc_dhcp_options" "main" {
  domain_name          = "us-east-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name = "dhcp-test"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}