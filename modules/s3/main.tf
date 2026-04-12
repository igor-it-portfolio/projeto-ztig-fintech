resource "aws_s3_bucket" "audit_log_bucket" {
  # Adicionamos o "var." e usamos o nome curto do módulo
  bucket = var.bucket_name 

  tags = {
    Name        = "Audit Logs ZTIG"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "trava_seguranca_bucket" {
  bucket = aws_s3_bucket.audit_log_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "IPDenyTotal"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
        Condition = {
          NotIpAddress = {
            # Aqui também é bom usar a variável do módulo se você a definiu
            "aws:SourceIp" = ["45.184.202.114/32"] 
          }
        }
      }
    ]
  })
}