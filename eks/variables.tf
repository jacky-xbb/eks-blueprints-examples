
variable "region" {
  description = "(Required) The region to deploy the cluster"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "(Required) The name of the cluster"
  type        = string
  default     = "emq"
}

variable "cluster_version" {
  description = "(Required) The version of the cluster"
  type        = string
  default     = "1.25"
}

variable "vpc_cidr" {
  description = "(Required) The CIDR block for the VPC"
  type        = string
  default = "10.0.0.0/16"
}

variable "role" {
  description = "(Required) The role of the instance"
  type = object({
    capacity_type = string
    node_group_name = string
    instance_types = list(string)
    desired_size    = string
    max_size        = string
    min_size        = string
  })
  default     = {
      capacity_type   = "ON_DEMAND"
      node_group_name = "general"
      instance_types  = ["t3a.xlarge"]
      desired_size    = "3"
      max_size        = "5"
      min_size        = "3"
  }
}
