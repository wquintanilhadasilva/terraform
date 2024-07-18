variable "location" {
  description = "Região onde os recursos serão criados na Azzure"
  type        = string
  default     = "West Europe"
}

variable "account_tier" {
  description = "Tier da Storage Account na Azzure"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Tipo de replicação de dados da Storage Account"
  type        = string
  default     = "LRS"
}

variable "resource_group_name" {
  description = "Nome do Resource Group"
  default     = "rg-curso-terraform"
}

variable "storage_account_name" {
  description = "Nome do Storage Account"
  default     = "wedsonsilvaterraform"
}

variable "container_name" {
  description = "Nome do Container"
  default     = "container-terraform"
}