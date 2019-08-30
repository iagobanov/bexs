resource "aws_iam_policy" "default" {
  name        = "${var.name}"
  path        = "${var.path}"
  description = "Managed by Terraform - ${var.description}"

  policy = "${data.template_file.policy.rendered}"
}

data "template_file" "policy" {
  template = "${file("${var.path_policy}")}"
}
