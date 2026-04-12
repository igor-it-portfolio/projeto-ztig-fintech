module "s3_bucket" {
  source      = "./modules/s3"
  bucket_name = var.audit_bucket_name  # O 'var.' aqui é obrigatório
  my_ip       = "45.184.202.114/32"
}

module "iam_permissions" {
  source      = "./modules/iam"
  bucket_arn  = "arn:aws:s3:::${var.audit_bucket_name}"
  my_ip       = "45.184.202.114/32"
}