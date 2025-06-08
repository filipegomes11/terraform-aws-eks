variable "cluster_name" {
  description = "name of the eks cluster"
  type        = string
}

variable "public_subnets" {
  type        = list(string)
  description = "public subnet to create the cluster"
}

