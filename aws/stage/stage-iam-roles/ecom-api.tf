###################################################
# Create IAM role Secret Manager - ecom-api
###################################################
resource "aws_iam_role" "ecom-api-role" {
  name = "ecom-api-iam-role"

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
                    "oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD:sub": "system:serviceaccount:stage-1:ecom-api-sa"
                }
            }
        }
    ]
}
EOF
}

###################################################
# Create IAM policy Secret Manager - ecom-api
###################################################
resource "aws_iam_policy" "ecom-api-policy" {
  name        = "ecom-api-iam-policy"
  description = "ecom-api-iam-policy"

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
            "Resource": "${aws_secretsmanager_secret.ecom-api-secret.arn}"
        }
    ]
}

EOF
}

###################################################
# Create IAM role policy attachment - ecom-api
###################################################
resource "aws_iam_role_policy_attachment" "ecom-api-attach" {
  role       = aws_iam_role.ecom-api-role.name
  policy_arn = aws_iam_policy.ecom-api-policy.arn
}

###################################################
# Create SecretManager secret item - ecom-api
###################################################
resource "aws_secretsmanager_secret" "ecom-api-secret" {
  name        = "ecom-api-env-20220908_1"
  description = "ecom-api-env-20220908_1"

  tags = {
    Name        = "ecom-api-env-20220908_1"
    Environment = "stage-1"
  }

}
