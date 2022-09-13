###################################################
# Create IAM role Secret Manager - rrad-api
###################################################
resource "aws_iam_role" "rrad-api-role" {
  name = "rrad-api-iam-role"

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
                    "oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD:sub": "system:serviceaccount:stage-1:rrad-api-sa"
                }
            }
        }
    ]
}
EOF
}

###################################################
# Create IAM policy Secret Manager - rrad-api
###################################################
resource "aws_iam_policy" "rrad-api-policy" {
  name        = "rrad-api-iam-policy"
  description = "rrad-api-iam-policy"

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
            "Resource": "${aws_secretsmanager_secret.rrad-api-secret.arn}"
        }
    ]
} 

EOF
}

###################################################
# Create IAM role policy attachment - rrad-api
###################################################
resource "aws_iam_role_policy_attachment" "rrad-api-attach" {
  role       = aws_iam_role.rrad-api-role.name
  policy_arn = aws_iam_policy.rrad-api-policy.arn
}

###################################################
# Create SecretManager secret item - rrad-api
###################################################
resource "aws_secretsmanager_secret" "rrad-api-secret" {
  name        = "rrad-api-env-20220908_1"
  description = "rrad-api-env-20220908_1"

  tags = {
    Name        = "rrad-api-env-20220908_1"
    Environment = "stage-1"
  }

}
