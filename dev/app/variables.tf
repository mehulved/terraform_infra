variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "stg", "prod"], var.environment)
    error_message = "Valid Environments - dev, stg, prod"
  }
}

variable "domain" {
  description = "TLD for the apps"
  type        = string
  default     = "one2n.local"
}

variable "storage_name" {
  description = "Name of the storage volume"
  type        = string
  default     = "app-storage"
}

variable "storage_requests" {
  description = "Requested storage for PV claim"
  type        = string
  default     = "5Gi"
}

variable "storage_capacity" {
  description = "Storage Capacity for PV claim"
  type        = string
  default     = "10Gi"
}

variable "app_name" {
  description = "Name of the app"
  type        = string
  default     = "app"
}

variable "app_port" {
  description = "Application Port"
  type        = number
  default     = 80
}