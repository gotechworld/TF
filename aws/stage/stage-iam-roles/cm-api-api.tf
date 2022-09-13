###################################################
# Create IAM role Secret Manager - cm-api
###################################################
resource "aws_iam_role" "cm-api-role" {
  name = "cm-api-iam-role"

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
                    "oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD:sub": "system:serviceaccount:stage-1:cm-sa"
                }
            }
        }
    ]
}
EOF
}

###################################################
# Create IAM policy Secret Manager - cm-api
###################################################
resource "aws_iam_policy" "cm-api-policy" {
  name        = "cm-api-iam-policy"
  description = "cm-api-iam-policy"

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
            "Resource": "${aws_secretsmanager_secret.cm-api-secret.arn}"
        }
    ]
} 

EOF
}

###################################################
# Create IAM role policy attachment - cm-api
###################################################
resource "aws_iam_role_policy_attachment" "cm-api-attach" {
  role       = aws_iam_role.cm-api-role.name
  policy_arn = aws_iam_policy.cm-api-policy.arn
}

###################################################
# Create SecretManager secret item - cm-api
###################################################
resource "aws_secretsmanager_secret" "cm-api-secret" {
  name        = "cm-api-env-20220908_1"
  description = "cm-api-env-20220908_1"

  tags = {
    Name        = "cm-api-env-20220908_1"
    Environment = "stage-1"
  }

}
