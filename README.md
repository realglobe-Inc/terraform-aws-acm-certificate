
[![GitHub][github-image]][github-link]

  [github-image]: https://img.shields.io/github/release/realglobe-Inc/terraform-aws-acm-certificate.svg
  [github-link]: https://github.com/realglobe-Inc/terraform-aws-acm-certificate/releases

# terraform-aws-acm-certificate

Provision an AWS certificate.

## Usage

```hcl
module "certificate" {
  source = "realglobe-Inc/acm-certificate/aws"
  version = "1.0.0"
  domain_names = ["example.com"]
  route53_zone_id = "xxxxxxx"
  acm_cert_tag_name = "example.com"
}
```

Output certificate ARN.

```hcl
output "arn" {
  value = module.certificate.arn
}
```

Create or switch workspace and apply.

```bash
$ terraform init
$ terraform workspace new development
$ terraform apply
```
