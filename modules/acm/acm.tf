resource "aws_acm_certificate" "test_cert" {
  domain_name               = "kwasipizza.click"
  subject_alternative_names = ["*.kwasipizza.click"]
  validation_method         = "DNS"
}

data "aws_route53_zone" "test_zone" {
  name         = "kwasipizza.click"
  private_zone = false
}

resource "aws_route53_record" "test_record" {
  for_each = {
    for dvo in aws_acm_certificate.test_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.test_zone.zone_id
}

resource "aws_acm_certificate_validation" "test_validation" {
  certificate_arn         = aws_acm_certificate.test_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.test_record : record.fqdn]
}
