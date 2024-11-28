output "arn" {
  description = "ARN if the ALB"
  value       = aws_lb.main.arn
}

output "security_group" {
  description = "ARN of the security group created for the ALB"
  value       = aws_security_group.lb.arn
}

output "acm_certificate" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.lb.arn
}

output "http_listener" {
  description = "ARN of the HTTP listener"
  value       = aws_lb_listener.http.arn
}

output "https_listener" {
  description = "ARN of the HTTPS listener"
  value       = aws_lb_listener.https.arn
}
