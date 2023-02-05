resource "tls_private_key" "terraform_generated_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "generated_key" {
  key_name   = var.ec2-key-name
  public_key = tls_private_key.terraform_generated_private_key.public_key_openssh

  provisioner "local-exec" {
    command = <<-EOT
    echo '${tls_private_key.terraform_generated_private_key.private_key_pem}'>mahmoud-key.pem
    chmod 400 mahmoud-key.pem
    EOT
  }
}


