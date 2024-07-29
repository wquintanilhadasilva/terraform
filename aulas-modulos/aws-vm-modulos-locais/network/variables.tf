variable "cidr_vpc" {
  description = "Cidr para a vpc criada na AWS"
  type        = string
}

variable "cidr_subnet" {
  description = "Cidr para a Subnet criada na AWS"
  type        = string
}

variable "environment" {
  description = "Nome do Ambiente dos recursos criado na AWS"
  type        = string
}