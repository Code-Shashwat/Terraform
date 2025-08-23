locals {
  double_numbers = [for num in var.numbers_list : num * 2]
  even_numbers   = [for num in var.numbers_list : num if num % 2 == 0]
  firstnames     = [for person in var.objects_list : person.firstname]
  fullnames      = [for person in var.objects_list : "${person.firstname} ${person.lastname}"]
  doubled_map = { for key, value in var.numbers_map : key => value * 2 }
  even_map = { for key, value in var.numbers_map : key => value if value%2 == 0 }

  user_map = {
    for user_info in var.users : user_info.username => user_info.role...
  }
  user_map2 = {
    for username, roles in local.user_map : username => {
      roles = roles
    }
  }

}

output "double_numbers" {
  value = local.double_numbers
}
output "even_numbers" {
  value = local.even_numbers
}
output "firstnames" {
  value = local.firstnames
}
output "fullnames" {
  value = local.fullnames
}
output "doubled_map" {
  value = local.doubled_map
}
output "even_map" {
  value = local.even_map
}
output "users_map" {
  value = local.user_map
}
output "users_map2" {
  value = local.user_map2
}
