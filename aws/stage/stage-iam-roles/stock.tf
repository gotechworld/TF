###################################################
# Create IAM role Secret Manager - stock
###################################################
resource "aws_iam_role" "stock-role" {
  name = "stock-iam-role"

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
                    "oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD:sub": "system:serviceaccount:stage-1:stock-sa"
                }
            }
        }
    ]
}
EOF
}

###################################################
# Create IAM policy Secret Manager - stock
###################################################
resource "aws_iam_policy" "stock-policy" {
  name        = "stock-iam-policy"
  description = "stock-iam-policy"

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
            "Resource": "${aws_secretsmanager_secret.stock-secret.arn}"
        }
    ]
} 

EOF
}

###################################################
# Create IAM role policy attachment - stock
###################################################
resource "aws_iam_role_policy_attachment" "stock-attach" {
  role       = aws_iam_role.stock-role.name
  policy_arn = aws_iam_policy.stock-policy.arn
}

###################################################
# Create SecretManager secret item - stock
###################################################
resource "aws_secretsmanager_secret" "stock-secret" {
  name        = "stock-env-20220908_1"
  description = "stock-env-20220908_1"

  tags = {
    Name        = "stock-env-20220908_1"
    Environment = "stage-1"
  }

}
