variable "enable_default_standards" {
  description = "Whether to enable the security standards that Security Hub has designated as automatically enabled including: `AWS Foundational Security Best Practices v1.0.0` and `CIS AWS Foundations Benchmark v1.2.0`"
  type        = bool
  default     = true
}

variable "enable_notifications" {
  description = "Enable send notifications to SNS Topic"
  type        = bool
  default     = false
}

variable "enabled_standards" {
  description = <<-DOC
  A list of standards/rulesets to enable
  See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription#argument-reference
  The possible values are:
    - standards/aws-foundational-security-best-practices/v/1.0.0
    - ruleset/cis-aws-foundations-benchmark/v/1.2.0
    - standards/pci-dss/v/3.2.1
  DOC
  type        = list(any)
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
