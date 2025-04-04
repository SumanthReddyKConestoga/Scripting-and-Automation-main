# Output all EC2 instance IDs.
output "refactored_instance_ids" {
  description = "List of EC2 instance IDs."
  value       = aws_instance.refactored_ec2[*].id
}

# Output the tags assigned to each EC2 instance.
output "refactored_instance_tags" {
  description = "Tags of each EC2 instance."
  value       = aws_instance.refactored_ec2[*].tags
}

# Output the computed maximum instance count using max() function.
output "max_instance_count" {
  description = "Maximum allowed instance count (computed using max())."
  value       = local.max_instance_count
}

# Output shortened instance IDs using substr() for better readability.
output "short_instance_ids" {
  description = "Shortened version of each instance ID (first 8 characters)."
  value       = [for id in aws_instance.refactored_ec2[*].id : substr(id, 0, 8)]
}
