# terraform-aws-security-hub

Terraform module that configures AWS Security Hub, subscriptions, finding aggregation,
and optional EventBridge notifications.

## Compatibility

This module requires Terraform 1.6.0 or later and supports AWS provider versions from 5.40.0 up to, but not including, 7.0.0.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.40.0, < 7.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.40.0, < 7.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.custom_action](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.imported](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.custom_action](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.imported](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_securityhub_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account) | resource |
| [aws_securityhub_finding_aggregator.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_finding_aggregator) | resource |
| [aws_securityhub_product_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_product_subscription) | resource |
| [aws_securityhub_standards_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource |
| [aws_partition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_event_rule_pattern"></a> [cloudwatch\_event\_rule\_pattern](#input\_cloudwatch\_event\_rule\_pattern) | The detail-type pattern used to match events that will be sent to SNS.<br/>For more information, see:<br/>https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/CloudWatchEventsandEventPatterns.html | `string` | `"{\n  \"detail\": {\n    \"findings\": {\n      \"Compliance\": {\n        \"Status\": [\n          \"FAILED\"\n        ]\n      }\n    }\n  },\n  \"detail-type\": [\n    \"Security Hub Findings - Imported\"\n  ],\n  \"source\": [\n    \"aws.securityhub\"\n  ]\n}\n"` | no |
| <a name="input_custom_action_notification_arn"></a> [custom\_action\_notification\_arn](#input\_custom\_action\_notification\_arn) | Notification ARN to send custom actions to (leave blank if not using custom actions) | `string` | `null` | no |
| <a name="input_enable_default_standards"></a> [enable\_default\_standards](#input\_enable\_default\_standards) | Whether to enable the security standards that Security Hub has designated as automatically enabled including: `AWS Foundational Security Best Practices v1.0.0` and `CIS AWS Foundations Benchmark v1.2.0` | `bool` | `true` | no |
| <a name="input_enable_notifications"></a> [enable\_notifications](#input\_enable\_notifications) | Enable send notifications to SNS Topic | `bool` | `false` | no |
| <a name="input_enabled_products_arn"></a> [enabled\_products\_arn](#input\_enabled\_products\_arn) | A list of subscription products arn to enable<br/>See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_product_subscription | `list(string)` | `[]` | no |
| <a name="input_enabled_standards_arn"></a> [enabled\_standards\_arn](#input\_enabled\_standards\_arn) | A list of standards/rulesets to enable<br/>See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription#argument-reference | `list(string)` | `[]` | no |
| <a name="input_finding_aggregator_enabled"></a> [finding\_aggregator\_enabled](#input\_finding\_aggregator\_enabled) | Enable finding aggretor | `bool` | `false` | no |
| <a name="input_finding_aggregator_linking_mode"></a> [finding\_aggregator\_linking\_mode](#input\_finding\_aggregator\_linking\_mode) | Indicates whether to aggregate findings from all of the available Regions or from a specified list. The options are ALL\_REGIONS, ALL\_REGIONS\_EXCEPT\_SPECIFIED or SPECIFIED\_REGIONS. When ALL\_REGIONS or ALL\_REGIONS\_EXCEPT\_SPECIFIED are used, Security Hub will automatically aggregate findings from new Regions as Security Hub supports them and you opt into them. | `string` | `"ALL_REGIONS"` | no |
| <a name="input_finding_aggregator_specified_regions"></a> [finding\_aggregator\_specified\_regions](#input\_finding\_aggregator\_specified\_regions) | List of regions to include or exclude (required if linking\_mode is set to ALL\_REGIONS\_EXCEPT\_SPECIFIED or SPECIFIED\_REGIONS) | `list(string)` | `null` | no |
| <a name="input_imported_finding_notification_arn"></a> [imported\_finding\_notification\_arn](#input\_imported\_finding\_notification\_arn) | Notification ARN to send imported findings to (leave blank if not using finding actions) | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_enabled_subscriptions"></a> [enabled\_subscriptions](#output\_enabled\_subscriptions) | A list of subscriptions that have been enabled |
<!-- END_TF_DOCS -->

## Example

See [`examples/complete`](examples/complete).
