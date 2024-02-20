terraform {
  backend "s3" {
    bucket         = "aws00-terraform-state"
    region         = "ap-northeast-2"
    key            = "infra/ec2/security_group/terraform.tfstate"
    dynamodb_table = "aws00-terraform-looks"
    encrypt        = true
  }
}