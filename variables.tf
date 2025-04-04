variable "desired_instance_count" {
  description = "Number of EC2 instances to launch."
  type        = number
  default     = 2
}

variable "scaling_factor" {
  description = "Factor to simulate maximum allowed instances in an autoscaling scenario."
  type        = number
  default     = 3
}

variable "instance_tags" {
  description = "Common tags for the EC2 instances."
  type        = map(string)
  default     = {
    project = "RefactorApp"
    role    = "web"
  }
}

variable "security_groups_map" {
  description = "Map of custom security groups to create."
  type = map(object({
    description = string
    port        = number
  }))
  default = {
    "web_sg" = {
      description = "Allow HTTP"
      port        = 80
    },
    "ssh_sg" = {
      description = "Allow SSH"
      port        = 22
    },
    "https_sg" = {
      description = "Allow HTTPS"
      port        = 443
    }
  }
}
