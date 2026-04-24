resource "aws_instance" "web_server" {
  ami           = var.ami_value
  instance_type = var.instance_value

  tags = {
    Name = "WebServer"
  }
}

