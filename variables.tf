variable "domain_names" {
  type = list(string)
}
variable "route53_zone_name" {}
variable "acm_cert_tag_name" {}
variable "validate_certificate" {
  type = bool
  default = true
}
