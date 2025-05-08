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

variable "volume_name" {
  description = "Name of the shared storage volume"
  type        = string
}

variable "storage_pool" {
  description = "Name of the storage pool"
  type        = string
}
