provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "mern" {
  tags = {
    Name = "Mern-crud-app-server"
  }

  ami                    = "ami-06259b63260eddc13"
  instance_type          = "t3.micro"
  key_name               = "devops-key"
  vpc_security_group_ids = [aws_security_group.mern_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io docker-compose-v2
    systemctl enable --now docker
    usermod -aG docker ubuntu
  EOF
}

resource "aws_security_group" "mern_sg" {
  name = "Mern-crud-app-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["106.219.227.47/32"]
  }
}
output "server_ip" {
  value = aws_instance.mern.public_ip
}
