resource "aws_iam_role" "iam_role" {
  name               = "iamrole-${random_id.rando.hex}"
  description        = "IAM Role"
  assume_role_policy = <<EOF
{
        "Version" : "2012-10-17",
        "Statement" : [
            {
                "Effect" : "Allow",
                "Action" : [
                    "sts:AssumeRole"
                ],
                "Principal" : {
                    "Service" : [
                        "ec2.amazonaws.com",
                        "lambda.amazonaws.com",
                        "s3.amazonaws.com"
                    ]
                }
            }
        ]
    }
EOF
  tags               = local.common-tags
}

resource "aws_iam_role_policy_attachment" "iam_role" {
  for_each   = var.policy-attach
  policy_arn = each.key
  role       = aws_iam_role.iam_role.name
}