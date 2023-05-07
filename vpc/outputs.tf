output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "subnet_ids"{
    value = {public = aws_subnet.public.*.id,
             private = aws_subnet.private.*.id}
}


output "secgp_management_id" {
  value = aws_security_group.ec2_ssh.id
}
