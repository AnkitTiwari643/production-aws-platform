output "alb_url" {
  description = "ALB DNS URL"
  value       = "http://${aws_lb.main.dns_name}"
}

output "ecr_url" {
  value = aws_ecr_repository.app.repository_url
}

output "ecs_cluster" {
  value = aws_ecs_cluster.main.name
}

output "ecs_service" {
  value = aws_ecs_service.app.name
}

output "rds_endpoint" {
  value     = aws_rds_cluster.main.endpoint
  sensitive = true
}
