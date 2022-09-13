###################################################
# Create IAM role Secret Manager - oms-api
###################################################
resource "aws_iam_role" "oms-api-role" {
  name = "oms-api-iam-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::009570627831:oidc-provider/oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD:sub": "system:serviceaccount:stage-1:oms-sa"
                }
            }
        }
    ]
}
EOF
}

###################################################
# Create IAM policy Secret Manager - oms-api
###################################################
resource "aws_iam_policy" "oms-api-policy" {
  name        = "oms-api-iam-policy"
  description = "oms-api-iam-policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetRandomPassword",
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret",
                "secretsmanager:ListSecretVersionIds"
            ],
            "Resource": "${aws_secretsmanager_secret.oms-api-secret.arn}"
        }
    ]
} 

EOF
}

###################################################
# Create IAM role policy attachment - oms-api
###################################################
resource "aws_iam_role_policy_attachment" "oms-api-attach" {
  role       = aws_iam_role.oms-api-role.name
  policy_arn = aws_iam_policy.oms-api-policy.arn
}

###################################################
# Create SecretManager secret item - oms-api
###################################################
resource "aws_secretsmanager_secret" "oms-api-secret" {
  name        = "oms-api-env-20220908_1"
  description = "oms-api-env-20220908_1"

  tags = {
    Name        = "oms-api-env-20220908_1"
    Environment = "stage-1"
  }

}
