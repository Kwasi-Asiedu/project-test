/*resource "aws_acm_certificate" "test_cert" {
  domain_name       = "kwasipizza.click"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}*/

data "aws_route53_zone" "test-zone" {
  name         = "kwasipizza.click"
  private_zone = false
}

resource "aws_route53_record" "test-record" {
  zone_id = data.aws_route53_zone.test-zone.zone_id
  name    = data.aws_route53_zone.test-zone.name
  type    = "A"
  

  alias {
    name = var.route53-lb-dns-name
    //name                   = aws_elb.main.dns_name
    zone_id = var.route-53-lb-zone-id
    //zone_id                = aws_elb.main.zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "test-recordd" {
  zone_id = data.aws_route53_zone.test-zone.zone_id
  name    = "*.kwasipizza.click"
  type    = "A"
  //records = [var.r53_acm_validation_record]

  alias {
    name = var.route53-lb-dns-name
    //name                   = aws_elb.main.dns_name
    zone_id = var.route-53-lb-zone-id
    //zone_id                = aws_elb.main.zone_id
    evaluate_target_health = true
  }
}








