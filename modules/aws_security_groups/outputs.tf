output "db_sg_id" {
  value = aws_security_group.sg_db.id
}

output "cache_sg_id" {
  value = aws_security_group.sg_cache.id
}