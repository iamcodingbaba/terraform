module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t2.micro"
  ami = "ami-020cba7c55df1f615" #ami of ubuntu
  key_name      = "india" # name of pem file
  monitoring    = false
  subnet_id     = "subnet-09fb3f4b15cf292d2" # id of subnet in which you want to create it
  associate_public_ip_address = true # to get public ip in ec2
  vpc_security_group_ids = ["sg-0c5f6e51f657a90ef"] # a security group written in aws account with desired ingress and egress rules , has to be in list


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
