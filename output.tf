output "connection string" {
  value = "ssh -L 8118:127.0.0.1:8118 freebsd@${digitalocean_droplet.tor.ipv4_address}"
}
