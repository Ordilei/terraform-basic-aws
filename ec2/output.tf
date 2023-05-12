output "ec2_public_ip" {
  value = flatten(["${aws_instance.ec2.*.public_ip}"])
}

output "ec2_private_ip" {
  value = flatten(["${aws_instance.ec2.*.private_ip}"])
}