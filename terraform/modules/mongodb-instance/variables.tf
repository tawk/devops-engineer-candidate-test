variable "name" {
  type        = string
  description = "Base name for the MongoDB instances."
}

variable "replica_count" {
  default = 2
}

variable "zone" {
}

variable "disk_size_gb" {
  type    = number
  default = 100
}

variable "labels" {
  type    = map(string)
  default = {}
}
