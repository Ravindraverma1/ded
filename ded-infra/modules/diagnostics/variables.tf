variable "law_id" { type = string }
variable "targets" {
  # map(name => resourceId)
  type = map(string)
}