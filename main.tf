
terraform {
  backend "atlas" {
    name    = "galser-free/lab-test"
  }
}

resource "null_resource" "helloWorld" {
  provisioner "local-exec" {
    command = "echo hello world"
  }
}
