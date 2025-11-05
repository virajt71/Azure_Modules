variable "playbook_filename" {
  description = "playbook file name"
  type        = string
}

variable "host_public_ip" {
  description = "public ip of host machine"
  type        = string
}

variable "replayable" {
  type    = bool
  default = false
}

variable "extra" {
  type = map(object({
    name               = string
    password           = string
    python_interpreter = optional(string)
    connection         = optional(string)
    ssh_common_args    = optional(string)
    become_password    = string
    host_key_checking  = optional(bool, false)
  }))
}
