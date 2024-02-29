resource "aws_instance" "jenkins" {
  ami                         = "ami-09eb4311cbaecf89d"
  instance_type               = "t2.micro"
  key_name                    = "aws00-key"
  // 퍼블릭 IP 활성화
  associate_public_ip_address = true
  security_groups             = [data.terraform_remote_state.security_group.outputs.ssh_id,
                                 data.terraform_remote_state.security_group.outputs.https_id,
                                 aws_security_group.jenkins-sg.id ]
  subnet_id = data.terraform_remote_state.vpc.outputs.public-subnet-2a-id

  user_data = templatefile("${path.module}/templates/user_data.sh", {})  

  tags = {
    Name = "aws00-jenkins"
  }
}

resource "aws_security_group" "jenkins-sg" {
  name   = "aws00-jenkins-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = var.jenkins_port
    to_port     = var.jenkins_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "aws00-jenkins-sg"
  }
}