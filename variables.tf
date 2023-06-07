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

variable "volume_name" {
  type = string
}

variable "word_count" {
  description = "How many words to echo"
  type        = number
  default     = 6
}

variable "phrase" {
  description = "Phrase to echo"
  type        = list(string)
  default = [
    "To",
    "be,",
    "or",
    "not",
    "to",
    "be"
  ]
}

variable "env_vars" {
  description = "Environment variables"
  type        = map(string)
  default = {
    EXT = "html"
  }
}
