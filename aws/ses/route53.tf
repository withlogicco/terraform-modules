resource "aws_route53_record" "ses_validation_record" {
  count   = var.route53_zone != null ? length(local.validation_dns_records) : 0
  zone_id = var.route53_zone
  name    = local.validation_dns_records[count.index].name
  type    = local.validation_dns_records[count.index].type
  records = [
    (local.validation_dns_records[count.index].type == "MX") ?
    "${local.validation_dns_records[count.index].priority} ${local.validation_dns_records[count.index].value}" :
    local.validation_dns_records[count.index].value
  ]
}
