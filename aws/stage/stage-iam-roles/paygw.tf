###################################################
# Create IAM role Secret Manager - paygw
###################################################
resource "aws_iam_role" "paygw-role" {
  name = "paygw-iam-role"

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
                    "oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD:sub": "system:serviceaccount:stage-1:paygw-sa"
                }
            }
        }
    ]
}
EOF
}

###################################################
# Create IAM policy Secret Manager - paygw
###################################################
resource "aws_iam_policy" "paygw-policy" {
  name        = "paygw-iam-policy"
  description = "paygw-iam-policy"

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
            "Resource": "${aws_secretsmanager_secret.paygw-secret.arn}"
        }
    ]
} 

EOF
}

###################################################
# Create IAM role policy attachment - paygw
###################################################
resource "aws_iam_role_policy_attachment" "paygw-attach" {
  role       = aws_iam_role.paygw-role.name
  policy_arn = aws_iam_policy.paygw-policy.arn
}

###################################################
# Create SecretManager secret item - paygw
###################################################
resource "aws_secretsmanager_secret" "paygw-secret" {
  name        = "paygw-env-20220908_1"
  description = "paygw-env-20220908_1"

  tags = {
    Name        = "paygw-env-20220908_1"
    Environment = "stage-1"
  }

}
