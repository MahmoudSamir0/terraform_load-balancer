module "mykey" {
  source="../keypair"
  ec2-key-name = "mahmoud-key"
}

module "mysecurity" {
  source = "../securitygroup"
  ivpc = module.netw.vpc

}
module "netw" {
  source = "../network"
  subnet_name_az1 = ["mypublic1", "myprivet1"]
subnet_id_az1   = ["10.0.0.0/24", "10.0.1.0/24"]
subnet_id_az2   = ["10.0.2.0/24", "10.0.3.0/24"]
subnet_name_az2 = ["mypublic2", "myprivet2"]
nat-name        = "mynat"
route-nat       = "myprivetnat"
rout-public     = "Public Route Table"
internet-get    = "internet-getway"
true-and-false  = ["true", "false"]
}