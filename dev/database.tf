resource "digitalocean_database_cluster" "mysqldb" {
  name       = "mysql-cluster"
  engine     = "mysql"
  version    = 8
  size       = "db-s-1vcpu-1gb"
  region     = var.region
  node_count = 1

  private_network_uuid = digitalocean_vpc.web_vpc.id
}

resource "digitalocean_database_firewall" "mysqldb-firewall" {
    
    cluster_id = digitalocean_database_cluster.mysqldb.id
    # allow connection from resources with a given tag
    rule {
        type = "tag"
        value = digitalocean_tag.do_tag.name
    }
}