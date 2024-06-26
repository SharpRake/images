terraform {
  required_providers {
    oci = { source = "chainguard-dev/oci" }
  }
}

variable "digest" {
  description = "The image digest to run tests over."
}

data "oci_exec_test" "help" {
  digest = var.digest
  script = "docker run --rm $IMAGE_NAME -help"
}

data "oci_exec_test" "test-bincapz" {
  digest = var.digest
  script = "docker run --rm $IMAGE_NAME /usr/bin/bincapz | grep Risk: | grep 4/CRITICAL"
}
