variable "ami_value" {
  description = "The ID of the AMI to use for the instance"
  type        = string
  default     = "ami-098e39bafa7e7303d" 
}

variable "instance_value" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}