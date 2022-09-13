###################################################
# Create IAM role Secret Manager - pp-api
###################################################
resource "aws_iam_role" "pp-api-role" {
  name = "pp-api-iam-role"

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
                    "oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD:sub": "system:serviceaccount:stage-1:pp-sa"
                }
            }
        }
    ]
}
EOF
}

###################################################
# Create IAM policy Secret Manager - pp-api
###################################################
resource "aws_iam_policy" "pp-api-policy" {
  name        = "pp-api-iam-policy"
  description = "pp-api-iam-policy"

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
            "Resource": "${aws_secretsmanager_secret.pp-api-secret.arn}"
        }
    ]
} 

EOF
}

###################################################
# Create IAM role policy attachment - pp-api
###################################################
resource "aws_iam_role_policy_attachment" "pp-api-attach" {
  role       = aws_iam_role.pp-api-role.name
  policy_arn = aws_iam_policy.pp-api-policy.arn
}

###################################################
# Create SecretManager secret item - pp-api
###################################################
resource "aws_secretsmanager_secret" "pp-api-secret" {
  name        = "pp-api-env-20220908_1"
  description = "pp-api-env-20220908_1"

  tags = {
    Name        = "paygw-api-env-20220908_1"
    Environment = "stage-1"
  }

}
