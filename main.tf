resource "aws_securityhub_account" "this" {
  enable_default_standards = var.enable_default_standards
}

resource "aws_securityhub_standards_subscription" "this" {
  for_each      = local.enabled_standards_arns
  depends_on    = [aws_securityhub_account.this]
  standards_arn = each.key
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
