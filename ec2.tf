module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t2.micro"
  ami = "ami-020cba7c55df1f615" #ami of ubuntu
  key_name      = "india" # name of pem file
  monitoring    = false
  subnet_id = module.vpc.public_subnets[0] # id of subnet in which you want to create ec2, the vpc and ec2 .tf files should be in the same directory to access each others output
  associate_public_ip_address = true # to get public ip in ec2
  vpc_security_group_ids = [module.range_22_to_443_sg.security_group_id] # output taken from module web_server_sg {we can change its name in security group.tf file and then here also.}


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
