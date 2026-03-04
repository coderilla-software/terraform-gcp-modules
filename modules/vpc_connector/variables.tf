variable "project_id" {
    description = "The ID of the project in which to create the VPC connector"
    type        = string
}

variable "region" {
    description = "The region in which to create the VPC connector"
    type        = string
}

variable "vpc_name" {
    description = "The name of the VPC in which to create the VPC connector"
    type        = string
}

variable "subnet_name" {
    description = "The name of the subnet in which to create the VPC connector"
    type        = string
}

variable "subnet_ip_range" {
    description = "The IP range of the subnet in which to create the VPC connector"
    type        = string
}

variable "connector_name" {
    description = "The name of the VPC connector"
    type        = string
}