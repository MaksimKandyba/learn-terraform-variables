variable "fly_region" {
  description = "Machine region"
  type        = string
  default     = "ams"
}

variable "external_port" {
  description = "Port application listens on externally"
  type        = number
  default     = 80
}

variable "encrypt_volume" {
  description = "Encrypt volume at rest"
  type        = bool
  default     = true
}
