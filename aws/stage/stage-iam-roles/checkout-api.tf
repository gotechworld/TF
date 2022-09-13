###################################################
# Create IAM role Secret Manager - checkout-api
###################################################
resource "aws_iam_role" "checkout-api-role" {
  name = "checkout-api-iam-role"

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
                    "oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD:sub": "system:serviceaccount:stage-1:checkout-sa"
                }
            }
        }
    ]
}
EOF
}

###################################################
# Create IAM policy Secret Manager - checkout-api
###################################################
resource "aws_iam_policy" "checkout-api-policy" {
  name        = "checkout-api-iam-policy"
  description = "checkout-api-iam-policy"

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
            "Resource": "${aws_secretsmanager_secret.checkout-api-secret.arn}"
        }
    ]
} 

EOF
}

###################################################
# Create IAM role policy attachment - checkout-api
###################################################
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.checkout-api-role.name
  policy_arn = aws_iam_policy.checkout-api-policy.arn
}

###################################################
# Create SecretManager secret item - checkout-api
###################################################
resource "aws_secretsmanager_secret" "checkout-api-secret" {
  name        = "checkout-api-env-20220908_1"
  description = "checkout-api-env-20220908_1"

  tags = {
    Name        = "checkout-api-env-20220908_1"
    Environment = "stage-1"
  }

}
