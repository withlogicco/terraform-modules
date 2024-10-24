resource "aws_route53_record" "ses_validation_record" {
  count   = var.route53_zone != null ? length(local.validation_dns_records) : 0
  zone_id = var.route53_zone
  name    = validation_dns_records_mailfrom_txt[count.index].name
  type    = validation_dns_records_mailfrom_txt[count.index].type
  records = [
    (validation_dns_records_mailfrom_txt[count.index].type == "MX") ?
    "${validation_dns_records_mailfrom_txt[count.index].priority} ${validation_dns_records_mailfrom_txt[count.index].value}" : validation_dns_records_mailfrom_txt[count.index].value
  ]
}
