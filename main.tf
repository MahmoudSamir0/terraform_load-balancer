module "load" {
    source = "./loadbalance"  
    ec2-ami         = "ami-00874d747dde814fa"
ec2-type        = "t2.micro"
}