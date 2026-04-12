variable "aws_region" {
  description = "Regiao onde a infra sera criada"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do Projeto da FinTech"
  default     = "ZTIG-Safe-Harbor"
}

variable "audit_bucket_name" {
  description = "Nome do bucket de logs da FinTech"
  default     = "fintech-global-audit-logs-2026-igor-v2"
}