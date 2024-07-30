resource "aws_s3_bucket" "bucket" {

  lifecycle {
    create_before_destroy = true
    ignore_changes = [ 
      tags
     ]
  }

  bucket = "wedsonsilva-lifecyle"

  tags = {
    test = "vscode"
  }

}