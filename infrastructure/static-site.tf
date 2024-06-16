locals {
  account_id = "381492084234"
  s3_origin_id = "tokyorust-origin"
  ssl_cert_arn = "arn:aws:acm:us-east-1:${local.account_id}:certificate/44db92d7-e5f4-4bca-b960-a3431da68659"
  host_name = "tokyorust.org"
  domain_name = "www.${local.host_name}"
}

resource "aws_s3_bucket" "tokyo-rust" {
  bucket = local.domain_name

  tags = {
    tokyorust = ""
    static = ""
  }
}

resource "aws_s3_bucket_policy" "cloudfront_access_policy" {
  bucket = aws_s3_bucket.tokyo-rust.id
  policy = data.aws_iam_policy_document.allow_cloudfront_read_access.json
}

data "aws_iam_policy_document" "allow_cloudfront_read_access" {
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
      aws_s3_bucket.tokyo-rust.arn,
      "${aws_s3_bucket.tokyo-rust.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }

  }
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

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.tokyo-rust.bucket_domain_name
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

resource "aws_cloudfront_cache_policy" "tokyorust" {
  name = "tokyo-tust-static-site-cache-policy"

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

resource "aws_route53_record" "tokyorust" {
  zone_id = aws_route53_zone.tokyorust.id
  name    = local.domain_name
  type    = "A"
  alias {
    name = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_iam_policy" "tokyorust-static-deployer" {
  name        = "tokyo-rust-static-deployer"
  description = "Necessary permissions to deploy the Tokyo Rust static site"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "AccessToWebsiteBuckets",
        Effect = "Allow",
        Action = [
          "s3:PutBucketWebsite",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        Resource = [
          "${aws_s3_bucket.tokyo-rust.arn}",
          "${aws_s3_bucket.tokyo-rust.arn}/*",
        ]
      },
      {
        Sid = "AccessToCloudfront",
        Effect = "Allow",
        Action = [
          "cloudfront:GetInvalidation",
          "cloudfront:CreateInvalidation"],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user" "tokyorust-static-deployer" {
  name = "tokyorust-static-deployer"
  path = "/"

  tags = {
    tokyorust = ""
    static = ""
  }
}

resource "aws_iam_user_policy_attachment" "tokyorust-static-deployer" {
  user   = aws_iam_user.tokyorust-static-deployer.name
  policy_arn  = aws_iam_policy.tokyorust-static-deployer.arn
}

resource "aws_s3_bucket_website_configuration" "tokyorust" {
  bucket = aws_s3_bucket.tokyo-rust.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }

}
