output "arn" {
  description = "AWS SecretManager Secret ARN"
  value       = aws_secretsmanager_secret.checkout-api-secret.arn
}

output "id" {
  description = "AWS SecretManager Secret ARN"
  value       = aws_secretsmanager_secret.checkout-api-secret.id
}
