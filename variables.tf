variable "enable_default_standards" {
  description = "Whether to enable the security standards that Security Hub has designated as automatically enabled including: `AWS Foundational Security Best Practices v1.0.0` and `CIS AWS Foundations Benchmark v1.2.0`"
  type        = bool
  default     = true
}

# Kept for backwards compatibility with the original public interface.
# tflint-ignore: terraform_unused_declarations
variable "enable_notifications" {
  description = "Enable send notifications to SNS Topic"
  type        = bool
  default     = false
}

variable "enabled_standards_arn" {
  description = <<-DOC
    A list of standards/rulesets to enable
    See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription#argument-reference
  DOC
  type        = list(string)
  default     = []
}

variable "enabled_products_arn" {
  description = <<-DOC
    A list of subscription products arn to enable
    See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_product_subscription
  DOC
  type        = list(string)
  default     = []
}

variable "custom_action_notification_arn" {
  description = "Notification ARN to send custom actions to (leave blank if not using custom actions)"
  default     = null
  type        = string
}

variable "imported_finding_notification_arn" {
  description = "Notification ARN to send imported findings to (leave blank if not using finding actions)"
  default     = null
  type        = string
}

variable "finding_aggregator_enabled" {
  description = "Enable finding aggretor"
  type        = bool
  default     = false
}

variable "finding_aggregator_linking_mode" {
  description = "Indicates whether to aggregate findings from all of the available Regions or from a specified list. The options are ALL_REGIONS, ALL_REGIONS_EXCEPT_SPECIFIED or SPECIFIED_REGIONS. When ALL_REGIONS or ALL_REGIONS_EXCEPT_SPECIFIED are used, Security Hub will automatically aggregate findings from new Regions as Security Hub supports them and you opt into them."
  type        = string
  default     = "ALL_REGIONS"
}

variable "finding_aggregator_specified_regions" {
  description = "List of regions to include or exclude (required if linking_mode is set to ALL_REGIONS_EXCEPT_SPECIFIED or SPECIFIED_REGIONS)"
  type        = list(string)
  default     = null
}

variable "cloudwatch_event_rule_pattern" {
  description = <<-DOC
  The detail-type pattern used to match events that will be sent to SNS.
  For more information, see:
  https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/CloudWatchEventsandEventPatterns.html
  DOC
  type        = string
  default     = <<EOF
{
  "detail": {
    "findings": {
      "Compliance": {
        "Status": [
          "FAILED"
        ]
      }
    }
  },
  "detail-type": [
    "Security Hub Findings - Imported"
  ],
  "source": [
    "aws.securityhub"
  ]
}
EOF
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  default     = {}
  type        = map(string)
}
