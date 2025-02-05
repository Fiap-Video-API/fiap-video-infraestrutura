# Configuração da Fila SQS processar
resource "aws_sqs_queue" "processar" {
  name                      = "processar"
  visibility_timeout_seconds = 300
  message_retention_seconds = 86400
  delay_seconds             = 1000
}

# Configuração da Fila SQS processados
resource "aws_sqs_queue" "processados" {
  name                      = "processados"
  visibility_timeout_seconds = 300
  message_retention_seconds = 86400
  delay_seconds             = 1000
}