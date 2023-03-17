variable "region" {
  type = string
  description = "value for the region"
}

variable "profile" {
  type = string
  description = "value for the profile"
}

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
