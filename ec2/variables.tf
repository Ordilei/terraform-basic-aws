variable "ec2_vpc_id" {
  type = string
}

variable "ec2_subnet_id" {
  type = string
}

variable "associate_public_ip_address" {
  type = bool
}

variable "key_pair_name" {
  type = string
}

variable "aws_security_group" {
  type = string  
}