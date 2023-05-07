data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = var.key_pair_name
  subnet_id = var.ec2_subnet_id
  vpc_security_group_ids = [var.aws_security_group]
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = "ec2-instance"
  }
}
