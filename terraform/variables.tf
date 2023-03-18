variable "vpc_cidr" {
  type = string
  description = "value for the CIDR block of the VPC"
}

variable "private_subnets" {
  type = list(string)
  description = "list of private subnets"
}

variable "public_subnets" {
  type = list(string)
  description = "list of public subnets"
}
