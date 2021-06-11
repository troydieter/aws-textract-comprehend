resource "aws_sns_topic" "snstopic" {
  name = "sns-${random_id.rando.hex}"
  tags = local.common-tags
}

resource "aws_sns_topic_subscription" "emailsub" {
  topic_arn = aws_sns_topic.snstopic.arn
  protocol  = "email"
  endpoint  = var.email
}