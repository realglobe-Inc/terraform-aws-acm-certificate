
[![GitHub][github-image]][github-link]

  [github-image]: https://img.shields.io/github/release/realglobe-Inc/terraform-aws-acm-certificate.svg
  [github-link]: https://github.com/realglobe-Inc/terraform-aws-acm-certificate/releases

# terraform-aws-acm-certificate

Provision an AWS certificate.

Terraform Registry at https://registry.terraform.io/modules/realglobe-Inc/acm-certificate/aws.

## Usage

```hcl
module "certificate" {
  source = "realglobe-Inc/acm-certificate/aws"
  version = "3.0.0"
  domain_names = ["example.com", "foo.example.com"]
  route53_zone_name = "example.com."
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

## Development

To publish new version in Terraform Registry, just create new release in [releases](https://github.com/realglobe-Inc/terraform-aws-acm-certificate/releases).
