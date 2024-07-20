resource "aws_s3_bucket" "wedson-bucket-state" {
  bucket = "wedson-state"

  tags = {
    Aula  = "30"
    Secao = "5"
  }
}