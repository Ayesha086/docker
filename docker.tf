resource "aws_instance" "this" {
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_all_docker.id]
  instance_type          =  "t3.micro"
  root_block_device{
    volume_size = 50 # Set root volume size to 50GB
    volume_type = "gp3" # Use gp3 for better performance
}
  user_data = file("docker.sh")
  tags = {
    Name = "docker"
  }
}

resource "aws_security_group" "allow_all_docker" {
  name        = "allow _all_docker"
  description = "Allow TLS inbound traffic and all outbound traffic"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "allow_tls"
  }
}
