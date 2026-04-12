# 1. Definição da Política de Função (Job Function Policy)
resource "aws_iam_policy" "auditor_job_function_policy" {
  name        = "FTG-JobFunction-Auditor-Permissions"
  description = "RBAC: Permissões de auditoria com bloqueio total se fora do IP"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyIfNotCorrectIP"
        Effect    = "Deny"
        Action    = "s3:*"
        # AJUSTE AQUI: Usando a variável do módulo
        Resource  = [
          "${var.bucket_arn}",
          "${var.bucket_arn}/*"
        ]
        Condition = {
          NotIpAddress = {
            "aws:SourceIp" = ["203.0.113.10/32"] 
          }
        }
      },
      {
        Sid       = "AllowAuditRead"
        Effect    = "Allow"
        Action    = ["s3:ListBucket", "s3:GetObject"]
        # AJUSTE AQUI: Usando a variável do módulo
        Resource  = [
          "${var.bucket_arn}",
          "${var.bucket_arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:MultiFactorAuthPresent" = "true"
          }
        }
      }
    ]
  })
}

# 2. Vínculo (Attachment) entre a Role e a Policy
resource "aws_iam_role_policy_attachment" "rbac_attachment" {
  role       = aws_iam_role.ftg_auditor_role.name
  policy_arn = aws_iam_policy.auditor_job_function_policy.arn
}