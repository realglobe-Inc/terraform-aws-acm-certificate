data "aws_route53_zone" "zone" {
  name = var.route53_zone_name
}

resource "aws_acm_certificate" "cert" {
  domain_name = var.domain_names[0]
  subject_alternative_names = slice(var.domain_names, 1, length(var.domain_names))
  validation_method = "DNS"

  tags = {
    Name = var.acm_cert_tag_name
  }

  lifecycle {
    create_before_destroy = true
    # SAN に複数のドメインを指定するとランダムな順序で並べ替えてリソースが作成されるため、apply するたびに再作成になる
    # 一時的な解決策として ignore_changes を使用する
    # See https://github.com/terraform-providers/terraform-provider-aws/issues/8531
    ignore_changes = [
      subject_alternative_names,
    ]
  }
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = aws_route53_record.cert_validation.*.fqdn
}

resource "aws_route53_record" "cert_validation" {
  count   = length(var.domain_names)
  name    = lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_name")
  type    = lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_type")
  records = [lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_value")]
  zone_id = data.aws_route53_zone.zone.zone_id
  ttl     = 60

  lifecycle {
    ignore_changes = ["fqdn"]
  }
}
