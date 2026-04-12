# Ativa o AWS IAM Access Analyzer para a conta (Nível Gratuito)
resource "aws_accessanalyzer_analyzer" "ftg_analyzer" {
  analyzer_name = "FTG-Account-Access-Analyzer"
  type          = "ACCOUNT"

  tags = {
    Project     = "ZTIG"
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}