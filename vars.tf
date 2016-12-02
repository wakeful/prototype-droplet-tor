variable "do_droplet_name" {
  description = "Droplet name"
  type = "string"

  default = "pTor"
}

variable "do_region" {
  description = "Default region"
  type = "string"

  default = "lon1"
}

variable "do_token" {
  description = "Digital Ocean access token"
  type = "string"
}

variable "ssh_key_path" {
  description = "Location of the public key that will be added to new droplet"
  type = "string"

  default = "~/.ssh/id_rsa.pub"
}

