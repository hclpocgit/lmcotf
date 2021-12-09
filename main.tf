provider "aws" {
  region = "ap-south-1"
  profile = "arn:aws:iam::072513753921:role/custom-ec2-terraform-role"
  # access_key = "AKIARBYRICNAVW2HF5WK"
  # secret_key = "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"
}

resource "aws_instance" "testtcec" {
  ami                    = "ami-07d280422a9f5ee93"
  instance_type          = "t2.micro"
  key_name               = "shailendra-mumbai-hclawsplm"
  monitoring             = true
  vpc_security_group_ids = ["sg-0df4b19389e5a3734"]
  subnet_id              = "subnet-030516bd5eb774591"
#vpc_id = "vpc-0023f24693d508a16"
  tags = {
    Name = "testtcec"
    Terraform   = "true"
    Environment = "dev"
  }
}

# resource "aws_vpc" "test-vpc-ss" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"

#   tags = {
#     Name = "testvpc-sstag"
#   }
# }
