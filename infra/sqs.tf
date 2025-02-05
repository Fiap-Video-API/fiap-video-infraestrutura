# Configuração da Fila SQS processar
resource "aws_sqs_queue" "processar" {
  name                      = "processar"
}

# Configuração da Fila SQS processados
resource "aws_sqs_queue" "processados" {
  name                      = "processados"
}