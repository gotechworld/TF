###################################################
# Create IAM role Secret Manager - paygw-api
###################################################
resource "aws_iam_role" "paygw-api-role" {
  name = "paygw-api-iam-role"

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
                    "oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD:sub": "system:serviceaccount:stage-1:paygw-api-sa"
                }
            }
        }
    ]
}
EOF
}

###################################################
# Create IAM policy Secret Manager - paygw-api
###################################################
resource "aws_iam_policy" "paygw-api-policy" {
  name        = "paygw-api-iam-policy"
  description = "paygw-api-iam-policy"

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
            "Resource": "${aws_secretsmanager_secret.paygw-api-secret.arn}"
        }
    ]
} 

EOF
}

###################################################
# Create IAM role policy attachment - paygw-api
###################################################
resource "aws_iam_role_policy_attachment" "paygw-api-attach" {
  role       = aws_iam_role.paygw-api-role.name
  policy_arn = aws_iam_policy.paygw-api-policy.arn
}

###################################################
# Create SecretManager secret item - paygw-api
###################################################
resource "aws_secretsmanager_secret" "paygw-api-secret" {
  name        = "paygw-api-env-20220908_1"
  description = "paygw-api-env-20220908_1"

  tags = {
    Name        = "paygw-api-env-20220908_1"
    Environment = "stage-1"
  }

}
