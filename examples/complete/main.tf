module "this" {
  source = "../../"

  enable_default_standards             = true
  finding_aggregator_enabled           = true
  finding_aggregator_linking_mode      = "SPECIFIED_REGIONS"
  finding_aggregator_specified_regions = ["us-east-1"]
  enabled_standards_arn                = []
  enabled_products_arn                 = []
  tags = {
    Example = "complete"
  }
}
