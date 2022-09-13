###################################################
# Create IAM role Secret Manager - global-config
###################################################
resource "aws_iam_role" "global-config-role" {
  name = "global-config-iam-role"

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
                    "oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD:sub": "system:serviceaccount:stage-1:global-config-sa"
                }
            }
        }
    ]
}
EOF
}

###################################################
# Create IAM policy Secret Manager - global-config
###################################################
resource "aws_iam_policy" "global-config-policy" {
  name        = "global-config-iam-policy"
  description = "global-config-iam-policy"

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
            "Resource": "${aws_secretsmanager_secret.global-config-secret.arn}"
        }
    ]
} 

EOF
}

###################################################
# Create IAM role policy attachment - global-config
###################################################
resource "aws_iam_role_policy_attachment" "global-config-attach" {
  role       = aws_iam_role.global-config-role.name
  policy_arn = aws_iam_policy.global-config-policy.arn
}

###################################################
# Create SecretManager secret item - global-config
###################################################
resource "aws_secretsmanager_secret" "global-config-secret" {
  name        = "global-config-env-20220908_1"
  description = "global-config-env-20220908_1"

  tags = {
    Name        = "global-config-env-20220908_1"
    Environment = "stage-1"
  }

}
