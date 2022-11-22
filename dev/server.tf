resource "digitalocean_tag" "do_tag" {
  name = "Web"
}

resource "digitalocean_droplet" "web" {
  image = "rockylinux-9-x64"
  count = var.droplet_count
  name = "web-${count.index + 1}"
  tags = [digitalocean_tag.do_tag.id]
  region = var.region
  size = "s-1vcpu-512mb-10gb"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
  vpc_uuid = digitalocean_vpc.web_vpc.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "digitalocean_loadbalancer" "public" {
  name = "loadbalancer-1"
  region = var.region
  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }
  healthcheck {
    port     = 22
    protocol = "tcp"
  }
  droplet_tag = "Web"
  vpc_uuid = digitalocean_vpc.web_vpc.id
}

resource "digitalocean_project_resources" "project_attach" {
  project = data.digitalocean_project.lab_project.id
  resources = flatten([digitalocean_droplet.web.*.urn])
}

resource "digitalocean_firewall" "web" {   
    name = "web-firewall"                                 #
    droplet_ids = digitalocean_droplet.web.*.id

    inbound_rule {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = [digitalocean_droplet.bastion.ipv4_address_private]
    }

    inbound_rule {
      protocol         = "tcp"
      port_range       = "80"
      source_load_balancer_uids = [digitalocean_loadbalancer.public.id]
    }

    inbound_rule {
      protocol         = "tcp"
      port_range       = "443"
      source_load_balancer_uids = [digitalocean_loadbalancer.public.id]
    }

    outbound_rule {
        protocol = "udp"
        port_range = "1-65535"
        destination_addresses = [digitalocean_vpc.web_vpc.ip_range]
    }

    outbound_rule {
        protocol = "tcp"
        port_range = "1-65535"
        destination_addresses = [digitalocean_vpc.web_vpc.ip_range]
    }

    outbound_rule {
        protocol = "icmp"
        destination_addresses = [digitalocean_vpc.web_vpc.ip_range]
    }

    # Selective Outbound Traffic Rules
    # HTTP
    outbound_rule {
        protocol = "tcp"
        port_range = "80"
        destination_addresses =  [digitalocean_loadbalancer.public.ip]
    }

    # HTTPS
    outbound_rule {
        protocol = "tcp"
        port_range = "443"
        destination_addresses =  [digitalocean_loadbalancer.public.ip]
    }

    # ICMP (Ping)
    outbound_rule {
        protocol              = "icmp"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }
}
