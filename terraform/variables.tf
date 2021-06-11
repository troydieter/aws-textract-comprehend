variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region to deploy to"
}

variable "aws_profile" {
  type        = string
  description = "AWS Profile to use credentials to deploy"
}

variable "email" {
  type        = string
  description = "Email address used for notifications"
}

variable "policy-attach" {
  default = {
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"                       = 1,
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess"                      = 2,
    "arn:aws:iam::aws:policy/AmazonSNSFullAccess"                      = 3,
    "arn:aws:iam::aws:policy/AWSLambda_FullAccess"                     = 4,
    "arn:aws:iam::aws:policy/AmazonTextractFullAccess"                 = 5,
    "arn:aws:iam::aws:policy/ComprehendMedicalFullAccess"              = 6,
    "arn:aws:iam::aws:policy/CloudWatchFullAccess"                     = 7,
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" = 8
  }
}