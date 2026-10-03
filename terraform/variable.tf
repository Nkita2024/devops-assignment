variable "availibility_zone" {
  description = "aws availibility zones"
  type        = string
  default     = "ap-south-1a"
}

variable "project_name" {
  description = "this is the default name for all resource"
  type        = string
  default     = "demo"
}

variable "vpc_cidr" {
  description = "cidr for the vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnet" {
  description = "this is the public subnet for vpc"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vpc_private_subnet" {
  description = "this the private subnet for vpc"
  type        = string
  default     = "10.0.2.0/24"
}

variable "db_password" {
  description = "Password for PostgreSQL database"
  type        = string
  sensitive   = true
}

