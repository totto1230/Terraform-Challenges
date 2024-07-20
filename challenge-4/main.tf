resource "aws_iam_user" "user" {

  count = var.number_of_users
  name = "${var.account_name}-${var.account_number}-${count.index}"
  path = "/"
}

output "names" {
   value = [for user in aws_iam_user.user : user.name]
}

output "number" {
   value = "Number of users created: ${var.number_of_users}"
}