variable "name" {
  type = string
}

variable "cpu" {
  type    = number
  default = 2
}

variable "memory" {
  type    = string
  default = "4GiB"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}