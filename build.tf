provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_ssh_key" "tor_key" {
  name = "${var.do_droplet_name} ssh key"
  public_key = "${file(var.ssh_key_path)}"
}

resource "digitalocean_droplet" "tor" {
  image = "freebsd-11-0-x64"
  name = "${var.do_droplet_name}"
  region = "${var.do_region}"
  size = "512mb"
  ssh_keys = ["${digitalocean_ssh_key.tor_key.id}"]
}

