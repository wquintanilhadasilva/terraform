resource "aws_key_pair" "key" {
  key_name   = "aws-key"
  public_key = file("./aws-key.pub")
}

resource "aws_instance" "vm" {
  ami                         = "ami-04a81a99f5ec58529"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id           # armazenado no state da configuração provisionada
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id] # armazenado no state da configuração provisionada
  associate_public_ip_address = true

  //hooks conforme ciclo de vida de execução do terraform
  lifecycle {
    # prevent_destroy = true // não permite que o terraform destrua o recurso
    replace_triggered_by = [ 
      aws_s3_bucket.bucket
    ]
  }

  tags = {
    Name = "vm-terraform"
  }
}