locals {
  # Merge dynamic tags using built-in functions.
  dynamic_tags = merge(
    var.instance_tags,
    {
      Deployed = formatdate("2006-01-02", timestamp()),
      Project  = upper(var.instance_tags["project"])
    }
  )
  
  # Compute the maximum allowed instance count using max()
  max_instance_count = max(var.desired_instance_count, var.scaling_factor)

  # Merge tag values using a space instead of a comma.
  merged_tags = join(" ", ["env:dev", "team:cloud"])
}

