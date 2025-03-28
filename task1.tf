provider "aws" {
  region = "us-east-1"
}

# Variables

variable "instance_count" {
  type    = number
  default = 3
}

variable "security_groups_map" {
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

# Using count to create identical EC2 instances

resource "aws_instance" "web_instances" {
  count         = var.instance_count
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 (replace with valid AMI in your region)
  instance_type = "t2.micro"

  tags = {
    Name = "Group3-${count.index}"
  }
}


# Using for_each to create uniquely configured security groups

resource "aws_security_group" "custom_sg" {
  for_each = var.security_groups_map

  name        = each.key
  description = each.value.description
  vpc_id      = "vpc-0f3fa0b8175452949" # Replace with your actual VPC ID

  ingress {
    from_port   = each.value.port
    to_port     = each.value.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = each.key
  }
}

# Outputs (optional)

output "instance_ids" {
  value = aws_instance.web_instances[*].id
}

output "security_group_ids" {
  value = [for sg in aws_security_group.custom_sg : sg.id]
}