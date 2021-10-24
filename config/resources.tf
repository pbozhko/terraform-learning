# This is a comment line

/*
  This is a multiline comment
*/

provider "aws" {}

data "aws_availability_zones" "working" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_ami" "latest_ubuntu" {
  owners = [
  "4657812154345"]
  most_recent = true
  filter {
    name = "name"
    values = [
    "ubuntu/images/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_instance" "my_web_server" {

  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [
    aws_security_group.my_webserver_sg
  ]

  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Pavel",
    l_name = "Bazhko",
    names = [
      "str1",
      "str2"
    ]
  })

  tags = {
    Name = "My Web Server Instance"
  }

  depends_on = [
    aws_instance.my_web_server_db
  ]
}

resource "aws_instance" "my_web_server_db" {

  ami           = "ami-4d6as54f5as4f6asf46a"
  instance_type = "t3.micro"

  vpc_security_group_ids = [
    aws_security_group.my_webserver_sg
  ]

  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Pavel",
    l_name = "Bazhko",
    names = [
      "str1",
      "str2"
    ]
  })

  tags = {
    Name = "My Web Server Database"
  }
}

resource "aws_security_group" "my_webserver_sg" {

  name        = "WebServer Security Group"
  description = "My first security group"

  dynamic "ingress" {
    for_each = [
      "80",
      "443"
    ]
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    }
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "My Web Server Security Group"
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      "ami",
    "user_data"]
    create_before_destroy = true
  }
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_web_server.id
}
