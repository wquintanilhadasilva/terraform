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

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> public_ip.txt"
  }

  # Define a conexão remota para essa máquina recém-criada para executar os provisioners seguintes na máquina recém-criada
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./aws-key")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo subnet_id ${data.terraform_remote_state.vpc.outputs.subnet_id} >> /tmp/network_info.txt",
      "echo security_group_id ${data.terraform_remote_state.vpc.outputs.security_group_id} >> /tmp/network_info.txt",
    ]
  }

  provisioner "file" {
    source      = "./teste.txt"
    destination = "/tmp/exemplo.txt"
  }

  provisioner "file" {
    content     = "ami used: ${self.ami}"
    destination = "/tmp/ami.txt"
  }

  tags = {
    Name = "vm-terraform"
  }
}
