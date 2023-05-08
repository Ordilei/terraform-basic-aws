
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_ssm_parameter" "ssm_key_pair_private_key" {
  name        = format("/ec2/key-pair/%s/private-rsa-key-pem", var.key_pair_name)
  type        = "String"
  value       = tls_private_key.ec2_key.private_key_pem
  overwrite   = true

  tags = {
      Name ="generic-private-key"
    }

  depends_on = [
    tls_private_key.ec2_key
  ]
}

resource "aws_ssm_parameter" "ssm_key_pair_private_key_rsa" {
  name        = format("/ec2/key-pair/%s/public-rsa-key-pem", var.key_pair_name)
  type        = "String"
  value       = tls_private_key.ec2_key.public_key_pem
  overwrite   = true

  tags = {
      Name = "generic-private-key-rsa"
  }

  depends_on = [
    tls_private_key.ec2_key
  ]
}

resource "aws_ssm_parameter" "ssm_key_pair_public_key" {
  name        = format("/ec2/key-pair/%s/public-rsa-key-openssh", var.key_pair_name)
  type        = "String"
  value       = tls_private_key.ec2_key.public_key_openssh
  overwrite   = true

  tags = {
      Name = "generic-public-key"
  }

  depends_on = [
    tls_private_key.ec2_key
  ]
}

resource "aws_key_pair" "ec2_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.ec2_key.public_key_openssh
  
  provisioner "local-exec"{
    command = "echo '${tls_private_key.ec2_key.private_key_pem}' > ./${var.key_pair_name}.pem && chmod 400 ${var.key_pair_name}.pem"
  }
}
