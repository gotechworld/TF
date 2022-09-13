###################################################
# Create IAM role Secret Manager - notif-api
###################################################
resource "aws_iam_role" "notif-api-role" {
  name = "notif-api-iam-role"

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
                    "oidc.eks.eu-central-1.amazonaws.com/id/0C29EFD8EAA6CA03F00737F7659040FD:sub": "system:serviceaccount:stage-1:notif-sa"
                }
            }
        }
    ]
}
EOF
}

###################################################
# Create IAM policy Secret Manager - notif-api
###################################################
resource "aws_iam_policy" "notif-api-policy" {
  name        = "notif-api-iam-policy"
  description = "notif-api-iam-policy"

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
            "Resource": "${aws_secretsmanager_secret.notif-api-secret.arn}"
        }
    ]
} 

EOF
}

###################################################
# Create IAM role policy attachment - notif-api
###################################################
resource "aws_iam_role_policy_attachment" "notif-api-attach" {
  role       = aws_iam_role.notif-api-role.name
  policy_arn = aws_iam_policy.notif-api-policy.arn
}

###################################################
# Create SecretManager secret item - notif-api
###################################################
resource "aws_secretsmanager_secret" "notif-api-secret" {
  name        = "notif-api-env-20220908_1"
  description = "notif-api-env-20220908_1"

  tags = {
    Name        = "notif-api-env-20220908_1"
    Environment = "stage-1"
  }

}
