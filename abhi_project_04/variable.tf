variable "vpc_cidr" {
    description = "The cidr block for vpc"
    default     = "10.0.0.0/16"
}

variable "public_subnet_01_cidr" {
    description = "The cidr block for public subnet"
    default     = "10.0.1.0/24"
}

variable "private_subnet_01_cidr" {
    description = "The cidr block for private subnet"
    default     = "10.0.2.0/24"
}

variable "public_subnet_02_cidr" {
    description = "The cidr block for public subnet"
    default     = "10.0.3.0/24"
}

variable "private_subnet_02_cidr" {
    description = "The cidr block for private subnet"
    default     = "10.0.4.0/24"
}   

