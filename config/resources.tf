# This is a comment line

/*
  This is a multiline comment
*/

provider "aws" {}

resource "aws_instance" "my_web_server" {

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
    Name = "My Web Server Instance"
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
}
