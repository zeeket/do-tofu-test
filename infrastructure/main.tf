resource "digitalocean_ssh_key" "terraform" {
  name       = "Terraform Example"
  public_key = var.pub_key
}

resource "digitalocean_droplet" "www-1" {
  image  = "ubuntu-20-04-x64"
  name   = "www-2"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    resource.digitalocean_ssh_key.terraform.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = var.pvt_key
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt update",
      "sudo apt install -y nginx"
    ]
  }
}