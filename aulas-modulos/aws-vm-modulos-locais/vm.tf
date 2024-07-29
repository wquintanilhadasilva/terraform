resource "aws_key_pair" "key" {
  key_name   = "aws-key-${var.environment}"
  public_key = file("./aws-key.pub")
}

resource "aws_instance" "vm" {
  ami                         = "ami-04a81a99f5ec58529"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = module.network.subnet_id
  vpc_security_group_ids      = [module.network.security_group_id] # armazenado no state da configuração provisionada
  associate_public_ip_address = true

  tags = {
    Name = "vm-${var.environment}"
  }
}