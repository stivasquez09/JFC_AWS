variable "table_name" {
  type    = string
  default = "orders"
}

variable "hash_key" {
  type    = string
  default = "orderId"
}

variable "tags" {
  type    = map(string)
  default = {
    Name = "Orders Table"
  }
}
