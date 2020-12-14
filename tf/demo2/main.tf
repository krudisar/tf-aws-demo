provider "aws" {
  #access_key = var.access_key
  #secret_key = var.secret_key
  region = "eu-west-1"
}

resource "aws_security_group" "vra-tf-demo-sg" {
  name = "vra-tf-demo-sg"
  description = "Demo SG created by VMware vRealize Automation"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }    

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ubuntu" {
  #key_name      = aws_key_pair.terraform_ec2_key.key_name
  ami           = "ami-00c25f7948e360133"
  instance_type = "t2.micro"
  count         = var.instances_count

  tags = {
    Name = "ubuntu-${count.index}"
  }

  vpc_security_group_ids = [
    aws_security_group.vra-tf-demo-sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
    host        = self.public_ip
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

