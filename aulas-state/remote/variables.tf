variable "location" {
  description = "Definição da localização do recurso"
  type        = string
  default     = "West Europe"
}

variable "account_tier" {
  description = "Tier da storage account"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication Account type"
  type        = string
  default     = "LRS"

}