resource "aws_key_pair" "git_key_pair" {
  key_name   = "my-key"
  public_key = file(var.key_pair_path)
}


resource "aws_instance" "git_instance" {

    ami=var.ami
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.cicd_sg.id]

    tags                   = {
        name               = "cicd_instance"
    }  
}