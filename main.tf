provider "aws" {
  region = var.region
}

# 1. Create IAM user for SES SMTP
resource "aws_iam_user" "ses_smtp_user" {
  name = "${var.namespace}-${var.environment}-ses-smtp-user"
}

# 2. Attach SES policy (send email)
resource "aws_iam_user_policy_attachment" "ses_policy" {
  user       = aws_iam_user.ses_smtp_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
}

# 3. Create IAM access key (SMTP credentials)
resource "aws_iam_access_key" "ses_smtp_key" {
  user = aws_iam_user.ses_smtp_user.name
}

# 4. Store Access Key ID in SSM Parameter Store
resource "aws_ssm_parameter" "ses_access_key" {
  name  = "/${var.namespace}/${var.environment}/ses_access_key"
  type  = "SecureString"
  value = aws_iam_access_key.ses_smtp_key.id
}

# 5. Store Secret Access Key in SSM Parameter Store
resource "aws_ssm_parameter" "ses_secret_access_key" {
  name  = "/${var.namespace}/${var.environment}/ses_secret_access_key"
  type  = "SecureString"
  value = aws_iam_access_key.ses_smtp_key.secret
}
