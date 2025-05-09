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
  default     = "vm-pool2"
  description = "Name of the existing LXD storage pool"
}

variable "volume_size" {
  type        = string
  default     = "10GiB"
  description = "Size of the attached custom volume"
}

variable "image" {
  type        = string
  default     = "ubuntu:noble/amd64"
  description = "Image to use for the LXD instance"
}

variable "cpu" {
  type        = number
  description = "Number of virtual CPUs to assign to each instance"
  default     = 2
}

variable "memory" {
  type        = string
  description = "Amount of RAM (e.g., 2048MB, 2GB) to assign to each instance"
  default     = "2048MB"
}