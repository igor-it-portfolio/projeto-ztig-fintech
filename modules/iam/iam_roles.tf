# Definição da ROLE (O Cargo no modelo RBAC)
resource "aws_iam_role" "ftg_auditor_role" {
  name = "FTG-Auditor-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" 
        }
      }
    ]
  })

  # TAGS: Isso é fundamental para evitar o Privilege Creep
  tags = {
    JobFunction = "Auditoria"
    Department  = "Compliance"
    ManagedBy   = "Terraform"
    Project     = "ZTIG"
  }
}