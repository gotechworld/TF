###################################################
# Create IAM role Secret Manager - cs-api
###################################################
resource "aws_iam_role" "cs-api-role" {
  name = "cs-api-iam-role"

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
                    "oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD:sub": "system:serviceaccount:stage-1:cs-sa"
                }
            }
        }
    ]
}
EOF
}

###################################################
# Create IAM policy Secret Manager - cs-api
###################################################
resource "aws_iam_policy" "cs-api-policy" {
  name        = "cs-api-iam-policy"
  description = "cs-api-iam-policy"

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
            "Resource": "${aws_secretsmanager_secret.cs-api-secret.arn}"
        }
    ]
} 

EOF
}

###################################################
# Create IAM role policy attachment - cs-api
###################################################
resource "aws_iam_role_policy_attachment" "cs-api-attach" {
  role       = aws_iam_role.cs-api-role.name
  policy_arn = aws_iam_policy.cs-api-policy.arn
}

###################################################
# Create SecretManager secret item - cs-api
###################################################
resource "aws_secretsmanager_secret" "cs-api-secret" {
  name        = "cs-api-env-20220908_1"
  description = "cs-api-env-20220908_1"

  tags = {
    Name        = "cs-api-env-20220908_1"
    Environment = "stage-1"
  }

}
