module "range_22_to_443_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "range_22_443_sg"
  description = "Security group allowing TCP traffic from port 22 to 443 from anywhere"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow TCP ports 22_443 from anywhere"
    }
  ]

  egress_rules = ["all-all"] # Allow all outbound traffic
}
