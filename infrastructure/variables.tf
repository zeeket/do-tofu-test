variable "do_token" {
    description = "Digital Ocean Token"
    type = string
    sensitive = true
}
variable "pvt_key" {
    description = "Private Key"
    type = string
    sensitive = true
}

variable "pub_key" {
    description = "Public Key"
    type = string
}
