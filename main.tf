resource "aws_securityhub_account" "this" {
  enable_default_standards = var.enable_default_standards
}

resource "aws_securityhub_finding_aggregator" "this" {
  count             = var.finding_aggregator_enabled ? 1 : 0
  linking_mode      = var.finding_aggregator_linking_mode
  specified_regions = var.finding_aggregator_specified_regions
}

resource "aws_securityhub_standards_subscription" "this" {
  for_each      = toset(var.enabled_standards_arn)
  standards_arn = each.value
  depends_on    = [aws_securityhub_account.this]
}

resource "aws_cloudwatch_event_rule" "imported" {
  count         = var.imported_finding_notification_arn == null ? 0 : 1
  name          = "securityhubevent-imported-findings"
  description   = "SecurityHubEvent - Imported Findings"
  tags          = var.tags
  event_pattern = var.cloudwatch_event_rule_pattern
}

resource "aws_cloudwatch_event_target" "imported" {
  count     = var.imported_finding_notification_arn == null ? 0 : 1
  rule      = aws_cloudwatch_event_rule.imported[0].name
  target_id = "SendToSNS"
  arn       = var.imported_finding_notification_arn
}

resource "aws_cloudwatch_event_rule" "custom_action" {
  count         = var.custom_action_notification_arn == null ? 0 : 1
  name          = "securityhubevent-custom-action"
  description   = "SecurityHubEvent - Custom Action"
  tags          = var.tags
  event_pattern = var.cloudwatch_event_rule_pattern
}

resource "aws_cloudwatch_event_target" "custom_action" {
  count     = var.custom_action_notification_arn == null ? 0 : 1
  rule      = aws_cloudwatch_event_rule.custom_action[0].name
  target_id = "SendToSNS"
  arn       = var.custom_action_notification_arn
}

resource "aws_securityhub_product_subscription" "this" {
  for_each    = toset(var.enabled_products_arn)
  product_arn = each.value
  depends_on  = [aws_securityhub_account.this]
}
