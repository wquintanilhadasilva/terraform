output "bucket_id" {
  description = "ID do Bucket criado"
  value       = aws_s3_bucket.wedson-bucket-state.id
}

output "bucket_arn" {
  description = "ARN do Bucket criado"
  value       = aws_s3_bucket.wedson-bucket-state.arn
}