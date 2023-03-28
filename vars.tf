variable "default_tags" {
  type = map(string)
  default = {
    "env" = "adonk"
  }
  description = "adonk variables description"
}

variable "public_subnet_count" {
  type        = number
  description = "public subnet count desription (optional)"
  default     = 2
}