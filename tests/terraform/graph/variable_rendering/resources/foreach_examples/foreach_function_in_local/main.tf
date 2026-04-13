locals {
  concat_list  = concat(["mail1", "mail2"], ["mail3"])
  flatten_list = flatten([["mail4", "mail5"], ["mail6"]])
  toset_concat = toset(concat(["mail7", "mail8"], ["mail9"]))
  count_val    = length(concat(["a", "b"], ["c"]))
  zipped       = zipmap(["a", "b"], ["val_a", "val_b"])
  upper_name   = upper("hello")
  joined       = join("-", ["a", "b"])
  derived      = flatten([local.concat_list, ["extra"]])
}

resource "aws_iam_group_membership" "concat_case" {
  for_each = toset(local.concat_list)
  name     = each.value
}

resource "aws_iam_group_membership" "flatten_case" {
  for_each = toset(local.flatten_list)
  name     = each.value
}

resource "aws_iam_group_membership" "toset_concat_case" {
  for_each = local.toset_concat
  name     = each.value
}

resource "aws_iam_group_membership" "count_case" {
  count = local.count_val
  name  = "member"
}

resource "aws_iam_group_membership" "map_case" {
  for_each = local.zipped
  name     = each.value
}

resource "aws_iam_group_membership" "upper_case" {
  for_each = toset([local.upper_name])
  name     = each.value
}

resource "aws_iam_group_membership" "join_case" {
  for_each = toset([local.joined])
  name     = each.value
}
