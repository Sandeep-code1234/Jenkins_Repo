resource "aws_instance" "git_instance" {

    ami=var.ami
    instance_type = var.instance_type

    tags = {
        name = "cicd_instance"
    }  
}