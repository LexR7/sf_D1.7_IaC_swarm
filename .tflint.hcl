config {
  module = true
  disabled_by_default = false

}
rule "terraform_comment_syntax" {
  enabled = true
}
rule "terraform_documented_outputs" {
  enabled = true
}
rule "terraform_documented_variables" {
  enabled = true
}
rule "terraform_typed_variables" {
  enabled = true
}
rule "terraform_unused_required_providers" {
  enabled = true
}