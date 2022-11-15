data "digitalocean_ssh_key" "ssh_key" {
  name = "lab5"
}

data "digitalocean_project" "lab_project" {
  name = "4640"
}