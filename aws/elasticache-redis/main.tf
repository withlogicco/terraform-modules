resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.name}-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "main" {
  cluster_id           = var.name
  engine               = "redis"
  engine_version       = "7.2"
  node_type            = var.node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  security_group_ids   = var.security_group_ids
}
