variable "cluster_name" {
  description = "name of the eks cluster"
  type        = string
}

variable "public_subnets" {
  type        = list(string)
  description = "public subnet to create the cluster"
}

variable "endpoint_private_access" {
  description = "Enable private endpoint access"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public endpoint access"
  type        = bool
  default     = true
}

variable "allowed_cidrs" {
  description = "List of CIDRs allowed to access EKS API"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}