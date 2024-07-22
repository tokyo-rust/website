locals {
  account_id = "381492084234"
  s3_origin_id = "tokyorust-origin"
  ssl_cert_arn = "arn:aws:acm:us-east-1:${local.account_id}:certificate/44db92d7-e5f4-4bca-b960-a3431da68659"
  host_name = "tokyorust.org"
  domain_name = "www.${local.host_name}"
}

resource "aws_s3_bucket" "www_tokyorust" {
  bucket = local.domain_name

  tags = {
    tokyorust = ""
    static = ""
  }
}

resource "aws_s3_bucket" "root_tokyorust" {
  bucket = local.host_name

  tags = {
    tokyorust = ""
   static = ""
  }
}

 resource "aws_s3_bucket_website_configuration" "root_tokyorust" {
  bucket = aws_s3_bucket.root_tokyorust.id

  redirect_all_requests_to {
    host_name =  "${local.domain_name}"
  }
}

data "aws_iam_policy_document" "www_tokyorust_allow_cloudfront_read_access" {
  version = "2012-10-17"
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    principals {
      type = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    effect = "Allow"
  
    resources = [
      aws_s3_bucket.www_tokyorust.arn,
      "${aws_s3_bucket.www_tokyorust.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudfront_distribution.www_distribution.arn]
    }

  }
}

data "aws_iam_policy_document" "root_tokyorust_allow_cloudfront_read_access" {
  version = "2012-10-17"
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    principals {
      type = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    effect = "Allow"
  
    resources = [
      aws_s3_bucket.root_tokyorust.arn,
      "${aws_s3_bucket.root_tokyorust.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudfront_distribution.root_distribution.arn]
    }

  }
}

resource "aws_s3_bucket_policy" "www_tokyorust_cloudfront_access_policy" {
  bucket = aws_s3_bucket.www_tokyorust.id
  policy = data.aws_iam_policy_document.www_tokyorust_allow_cloudfront_read_access.json
}

resource "aws_s3_bucket_policy" "root_tokyorust_cloudfront_access_policy" {
  bucket = aws_s3_bucket.root_tokyorust.id
  policy = data.aws_iam_policy_document.root_tokyorust_allow_cloudfront_read_access.json
}

resource "aws_cloudfront_origin_access_control" "tokyorust" {
  name                              = "Tokyo-Rust-Access"
  description                       = "The access control for the Tokyo Rust website."
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_origin_access_identity" "tokyorust" {
  comment = "Access identity for Tokyo Rust static site"
}

resource "aws_cloudfront_distribution" "www_distribution" {
  origin {
    domain_name              = aws_s3_bucket.www_tokyorust.bucket_domain_name
    origin_id                = local.s3_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.tokyorust.id

    # s3_origin_config {
    #   origin_access_identity = aws_cloudfront_origin_access_identity.tokyorust.cloudfront_access_identity_path
    # }
  }

  aliases = [local.domain_name]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = local.ssl_cert_arn
    ssl_support_method = "sni-only"
  }

  enabled = true
  comment = "CloudFront distribution for ${local.domain_name}"
  default_root_object = "index.html"
  http_version = "http2"
  is_ipv6_enabled = true
  custom_error_response {
    error_code = 404
    response_code = 404
    response_page_path = "/404.html"
  }

  default_cache_behavior {
    compress = true
    viewer_protocol_policy = "redirect-to-https"
    cached_methods = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    allowed_methods = ["GET", "HEAD"]
    default_ttl = 86400
    max_ttl = 31536000
    cache_policy_id = aws_cloudfront_cache_policy.tokyorust.id
 }

  price_class = "PriceClass_200"

  tags = {
    tokyorust = ""
    static = ""
  }
}

resource "aws_cloudfront_distribution" "root_distribution" {
  origin {
    domain_name              = aws_s3_bucket_website_configuration.root_tokyorust.website_endpoint
    origin_id                = local.s3_origin_id

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port  = "80"
      https_port = "443"
      origin_ssl_protocols = ["TLSv1.2"]
    }

    # s3_origin_config {
    #   origin_access_identity = aws_cloudfront_origin_access_identity.tokyorust.cloudfront_access_identity_path
    # }
  }

  aliases = [local.host_name]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = local.ssl_cert_arn
    ssl_support_method = "sni-only"
  }

  enabled = true
  comment = "CloudFront distribution for ${local.host_name}"
  default_root_object = "index.html"
  http_version = "http2"
  is_ipv6_enabled = true

  default_cache_behavior {
    compress = true
    viewer_protocol_policy = "redirect-to-https"
    cached_methods = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    allowed_methods = ["GET", "HEAD"]
    default_ttl = 86400
    max_ttl = 31536000
    cache_policy_id = aws_cloudfront_cache_policy.tokyorust.id
 }

  price_class = "PriceClass_200"

  tags = {
    tokyorust = ""
    static = ""
  }
}

resource "aws_cloudfront_cache_policy" "tokyorust" {
  name = "tokyo-rust-static-site-cache-policy"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }

    headers_config {
      header_behavior = "none"
    }
  }
}

resource "aws_route53_zone" "tokyorust" {
  name = "tokyorust.org"
  tags = {
    tokyorust = ""
    static = ""
  }
}

resource "aws_route53_record" "www_tokyorust" {
  zone_id = aws_route53_zone.tokyorust.id
  name    = local.domain_name
  type    = "A"
  alias {
    name = aws_cloudfront_distribution.www_distribution.domain_name
    zone_id = aws_cloudfront_distribution.www_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "root_tokyorust" {
  zone_id = aws_route53_zone.tokyorust.id
  name    = local.host_name
  type    = "A"
  alias {
    name = aws_cloudfront_distribution.root_distribution.domain_name
    zone_id = aws_cloudfront_distribution.root_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_iam_user" "tokyorust-static-deployer" {
  name = "tokyorust-static-deployer"
  path = "/"

  tags = {
    tokyorust = ""
    static = ""
  }
}

resource "aws_s3_bucket_website_configuration" "tokyorust" {
  bucket = aws_s3_bucket.www_tokyorust.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }

}
