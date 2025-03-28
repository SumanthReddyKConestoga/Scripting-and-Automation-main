
# Terraform & Provider Setup


provider "aws" {
  region = "us-east-1"
}

# Variables

variable "instance_count" {
  type    = number
  default = 2
}

variable "instance_tags" {
  type = map(string)
  default = {
    project = "RefactorApp"
    role    = "web"
  }
}


# Local values using built-in functions

locals {
  dynamic_tags = merge(
    var.instance_tags,
    {
      Deployed = formatdate("YYYY-MM-DD", timestamp()) # Date/Time
      Project  = upper(var.instance_tags["project"])   # String
    }
  )
}

# Refactored EC2 using count and dynamic expressions

resource "aws_instance" "refactored_ec2" {
  count         = var.instance_count
  ami           = "ami-0c55b159cbfafe1f0" # Replace with valid AMI ID in your region
  instance_type = "t2.micro"

  tags = merge(
    local.dynamic_tags,
    {
      Name = "Group4ec2-${count.index}"
    }
  )
}


# Outputs

output "refactored_instance_ids" {
  value = aws_instance.refactored_ec2[*].id
}

output "refactored_instance_tags" {
  value = aws_instance.refactored_ec2[*].tags
}