data "aws_partition" "this" {}
data "aws_region" "this" {}

locals {
  enabled_standards_arns = toset([
    for standard in var.enabled_standards :
    format("arn:%s:securityhub:%s::%s", data.aws_partition.this.partition, length(regexall("ruleset", standard)) == 0 ? data.aws_region.this.name : "", standard)
  ])
}
