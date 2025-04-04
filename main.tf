# Create EC2 Instances for the web tier using count.
resource "aws_instance" "refactored_ec2" {
  count         = var.desired_instance_count
  ami           = data.aws_ami.amazon_linux.id  # Updated to use dynamic AMI
  instance_type = "t2.micro"

  tags = merge(
    local.dynamic_tags,
    {
      Name = "Group4ec2-${count.index}"
    }
  )
}

# Create custom security groups using for_each.
resource "aws_security_group" "custom_sg" {
  for_each    = var.security_groups_map
  name        = each.key
  description = each.value.description
  vpc_id      = data.aws_vpc.default.id  # Updated to use the default VPC

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

# Generate a random suffix for the S3 bucket name.
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Create an S3 bucket and enforce lowercase naming using lower().
resource "aws_s3_bucket" "function_demo_bucket" {
  bucket = lower("Functions-demo-${random_id.bucket_suffix.hex}")

  tags = {
    Project       = local.dynamic_tags["Project"]
    DeployedOn    = local.dynamic_tags["Deployed"]
    InstanceCount = tostring(var.desired_instance_count)
    MaxInstances  = tostring(local.max_instance_count)
    Notes         = local.merged_tags
  }
}
