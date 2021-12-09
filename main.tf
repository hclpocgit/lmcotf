provider "aws" {
  region = "ap-south-1"
  profile = "arn:aws:iam::072513753921:role/custom-ec2-terraform-role"
  # access_key = "AKIARBYRICNAVW2HF5WK"
  # secret_key = "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"
}

resource "aws_instance" "testtcec" {
  ami                    = "ami-07d280422a9f5ee93"
  instance_type          = "t3.large"
  key_name               = "shailendra-mumbai-hclawsplm"
  monitoring             = true
  vpc_security_group_ids = ["sg-0df4b19389e5a3734"]
  subnet_id              = "subnet-030516bd5eb774591"
#vpc_id = "vpc-0023f24693d508a16"
  tags = {
    Name = "lmco-tc-poc"
    Terraform   = "true"
    Environment = "dev"
  }
}
