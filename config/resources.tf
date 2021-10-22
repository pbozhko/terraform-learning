provider "aws" {}

resource "aws_instance" "test_instance_ubuntu" {

  count         = 1
  ami           = "ami-4d6as54f5as4f6asf46a"
  instance_type = "t3.micro"

  tags = {
    Name    = "Test AWS Ubuntu Instance",
    Owner   = "Pavel Bazhko",
    Project = "Terraform Lessons"
  }
}

resource "aws_instance" "test_instance_centos" {

  count         = 2
  ami           = "ami-0302f3ec240b9d23c"
  instance_type = "t3.micro"

  tags = {
    Name    = "Test AWS Centos Instance",
    Owner   = "Pavel Bazhko",
    Project = "Terraform Lessons"
  }
}
