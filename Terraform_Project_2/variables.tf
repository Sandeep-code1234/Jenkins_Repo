variable "region" {
    type = string
}

variable "ami" {
    type =string
}

variable "instance_type" {
    type = string 
}

variable "vpc_cidr" {
    type = string
}
variable "public_subnet_cidr" {
    type = string
}

variable "private_subnet_cidr" {
    type = string
}

variable "key_pair_path" {
   type  = string
}