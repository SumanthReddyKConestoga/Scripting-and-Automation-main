

provider "aws" {
  region = "us-east-1"
}

# Local values using functions

locals {
  # String function: upper()
  project_name = upper("ApplicationLab8")

  # Numeric function: min()
  smallest_number = min(4, 9, 2)

  # Collection function: concat()
  merged_tags = concat(["env:dev"], ["team:cloud"])

  # Date/time function: formatdate() with timestamp()
  deployment_date = formatdate("YYYY-MM-DD", timestamp())

  # IP/Networking function: cidrsubnet()
  subnet_cidr = cidrsubnet("10.0.0.0/16", 8, 5)
}

# Random ID for S3 bucket name

resource "random_id" "bucket_suffix" {
  byte_length = 4
}


# Sample AWS S3 bucket using functions

resource "aws_s3_bucket" "function_demo_bucket" {
  bucket = "functions-demo-${random_id.bucket_suffix.hex}"

  tags = {
    Project        = local.project_name              # String function result
    DeployedOn     = local.deployment_date           # Date/time function result
    SmallestValue  = tostring(local.smallest_number) # Numeric function result
    SubnetCIDR     = local.subnet_cidr               # IP function result
    Notes          = join(", ", local.merged_tags)   # Collection function result
  }
}