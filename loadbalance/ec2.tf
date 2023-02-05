resource "aws_instance" "mypub-ec2-1" {
  ami                         = var.ec2-ami
  instance_type               = var.ec2-type
  key_name                    = module.mykey.key-ec2-key
  subnet_id                   = module.netw.publice_ip_az1
  vpc_security_group_ids = [module.mysecurity.my_public_ec2_sg_id]
  associate_public_ip_address = true
   provisioner "remote-exec" {
    inline = [
"sudo apt-get update -y",
"sudo apt install nginx -y",
"sudo echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${aws_lb.pri_load.dns_name}; \n  } \n}' > default",
"sudo mv default /etc/nginx/sites-enabled/default",
"sudo service nginx restart"
    ]
  }
    connection {
    host     = self.public_ip
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./mahmoud-key.pem")
    timeout = 2
    }
  provisioner "local-exec" {
    command = "echo public-ip1 ${self.public_ip} >> all-ip.txt"
  }   
   
}
resource "aws_instance" "mypub-ec2-2" {
  ami                         = var.ec2-ami
  instance_type               = var.ec2-type
  key_name                    = module.mykey.key-ec2-key
  subnet_id                   = module.netw.publice_ip_az2
  vpc_security_group_ids = [module.mysecurity.my_public_ec2_sg_id]
  associate_public_ip_address = true
  provisioner "remote-exec" {
    inline = [
"sudo apt-get update -y",
"sudo apt install nginx -y",
"sudo echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${aws_lb.pri_load.dns_name}; \n  } \n}' > default",
"sudo mv default /etc/nginx/sites-enabled/default",
"sudo service nginx restart"
    ]
  }
    connection {
    host     = self.public_ip
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./mahmoud-key.pem")
    timeout = 2

    }
  provisioner "local-exec" {
    command = "echo public-ip2 ${self.public_ip} >> all-ip.txt"
  }
  
}

resource "aws_instance" "myprivetsub-ec2-1" {
  ami             = var.ec2-ami
  instance_type   = var.ec2-type
  key_name        = module.mykey.key-ec2-key
  subnet_id       = module.netw.privat_ip_az1
  vpc_security_group_ids = [module.mysecurity.my_private_ec2_sg_id]
  user_data                   = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  sudo echo "hello from private ec2 $HOSTNAME" > /var/www/html/index.html
  EOF

  provisioner "local-exec" {
    command = "echo private-ip1 ${self.private_ip} >> all-ip.txt"
  }

}

resource "aws_instance" "myprivetsub-ec2-2" {
  ami             = var.ec2-ami
  instance_type   = var.ec2-type
  key_name        = module.mykey.key-ec2-key
  subnet_id       = module.netw.privat_ip_az2
  vpc_security_group_ids = [module.mysecurity.my_private_ec2_sg_id]
  user_data                   = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install apache2 -y
  echo "hello from private ec2 $HOSTNAME" > /var/www/html/index.html
  EOF
  provisioner "local-exec" {
    command = "echo private-ip2 ${self.private_ip} >> all-ip.txt"
  }

}