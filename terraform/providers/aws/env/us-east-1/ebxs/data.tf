# # data "aws_acm_certificate" "aws_guiabolso" {
# #   domain      = "*.guiabolso.in"
# #   statuses    = ["ISSUED"]
# #   most_recent = true
# # }

# data "aws_route53_zone" "selected" {
#   name         = "${var.zone_name}"
#   private_zone = true
# }

# data "aws_vpc" "vpc" {
#   tags = {
#     Name = "vpc-guiabolso"
#   }
# }
