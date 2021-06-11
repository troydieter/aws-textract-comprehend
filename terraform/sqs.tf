resource "aws_sqs_queue" "ALLEQUEUE" {
  name                       = "queue-${random_id.rando.hex}"
  visibility_timeout_seconds = 240
  tags                       = local.common-tags
}

resource "aws_sqs_queue" "VALIDATEQUEUE" {
  name                       = "queue-validate-${random_id.rando.hex}"
  visibility_timeout_seconds = 240
  tags                       = local.common-tags
}

resource "aws_sqs_queue" "INVALIDATEQUEUE" {
  name = "queue-invalidate-${random_id.rando.hex}"
  tags = local.common-tags
}