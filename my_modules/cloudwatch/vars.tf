variable "log_group_name" {
  description = "Nombre del grupo de logs"
  type        = string
}

variable "retention_in_days" {
  description = "Días de retención de logs"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Etiquetas para el log group"
  type        = map(string)
  default     = {}
}
