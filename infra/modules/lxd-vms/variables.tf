variable "instance_count" {
  type        = number
  description = "Number of LXD instances to create"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for VM names"
}

variable "pool_name" {
  type        = string
  default     = "vm-pool"
  description = "Name of the existing LXD storage pool"
}

variable "volume_size" {
  type        = string
  default     = "5GiB"
  description = "Size of the attached custom volume"
}

variable "image" {
  type        = string
  default     = "ubuntu:22.04"
  description = "Image to use for the LXD instance"
}
