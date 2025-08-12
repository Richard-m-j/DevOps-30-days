provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
}

resource "aws_instance" "web" {
  ami = "ami-0a84ffe13366e143f"
  instance_type = "t2.nano"
  key_name = "richardnv"
  tags = {
    Name = "Richard Instance"
  }
}