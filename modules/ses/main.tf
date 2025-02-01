# ses.tf
resource "aws_ses_email_identity" "notification_email" {
  email = "wanderson.p.ayres@gmail.com"
}