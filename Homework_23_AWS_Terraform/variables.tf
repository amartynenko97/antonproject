variable "access_key" {
      description = "Access key to AWS console"
      
}
variable "secret_key" {
      description = "Secret key to AWS console"
     

variable "aws_region" {
      description = "region for lauch resourses"
      default     = "us-east-2"
      type        = string
}

variable "vpc_cidr" {
      description = "virual network for two subnets"
      default     = "10.0.0.0/16"
      type        = string
}

variable "vpc_cidr_public" {
      description = "Public subnet"
      default     = "10.0.100.0/24"
      type        = string
}

variable "vpc_cidr_private" {
      description = "Private subnet"
      default     = "10.0.200.0/24"
      type        = string
}

variable "instance_type" {
      type        = string
      default     = "t2.micro"
}

variable "instance_ami" {
      type        = string
      default     = "ami-0f924dc71d44d23e2"
} 