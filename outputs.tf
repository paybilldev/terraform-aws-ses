output "ses_smtp_user" {
  value = aws_iam_user.ses_smtp_user.name
}

output "ses_access_key_param" {
  value = aws_ssm_parameter.ses_access_key.name
}

output "ses_secret_access_key_param" {
  value = aws_ssm_parameter.ses_secret_access_key.name
}
