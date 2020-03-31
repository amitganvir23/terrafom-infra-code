resource "aws_iam_role" "kafka_role" {
  name = "${var.environment}-${var.kafka_service_name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {"Service": ["ec2.amazonaws.com"]},
      "Action": ["sts:AssumeRole"]
    }
  ]
}
EOF
}

/* Profile is how we attach role to instances */
resource "aws_iam_instance_profile" "kafka_profile" {
  name  = "${var.environment}-${var.kafka_service_name}-profile"
  role  = aws_iam_role.kafka_role.name
}


resource "aws_iam_role_policy" "kafka_policy" {
  name = "${var.environment}-${var.kafka_service_name}-kafka_policy"
  role = aws_iam_role.kafka_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateTags",
        "ec2:Describe*",
        "autoscaling:DescribeAutoScalingGroups",
        "cloudwatch:PutMetricData",
        "cloudwatch:PutDashboard",
        "cloudwatch:PutMetricAlarm",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics",
        "ec2:DescribeTags",
        "autoscaling:DescribeAutoScalingGroups",
        "route53:GetHostedZone",
        "route53:CreateHostedZone",
        "route53:ChangeResourceRecordSets",
        "route53:List*",
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
