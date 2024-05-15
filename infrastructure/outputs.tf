output "www-1_ipv4_address" {
  value       = digitalocean_droplet.www-1.ipv4_address
  description = "The public IPv4 address of the www-1 droplet."
}