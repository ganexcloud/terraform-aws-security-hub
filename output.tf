output "enabled_subscriptions" {
  description = "A list of subscriptions that have been enabled"
  value = [
    for standard in aws_securityhub_standards_subscription.this :
    standard.id
  ]
}
