output "server_ip" {
  value = digitalocean_droplet.web.*.ipv4_address
  description = "The ip address of web servers"
}

output "database_url" {
  value = digitalocean_database_cluster.postgres-cluster.uri
  description = "The database connection's full url"
}