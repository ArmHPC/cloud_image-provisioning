#!/bin/bash

# Function to create a Packer template file
create_packer_template() {
    cat << EOF > ../images/"$1"
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

packer {
  required_plugins {
    amazon = {
      version = "~> 1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }


# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioners and post-processors on a
# source.

source "amazon-ebs" "example" {
  ami_name      = "terraform-packer-\${local.timestamp}"
  instance_type = "$2"
  region        = "$3"
  source_ami_filter {
    filters = {
      name                = "$4"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

# a build block invokes sources and runs provisioning steps on them.
build {
  sources = ["source.amazon-ebs.example"]

  provisioner "file" {
    source      = "../tf-packer.pub"
    destination = "/tmp/tf-packer.pub"
  }
  provisioner "shell" {
    script = "../scripts/setup.sh"
  }
  post-processor "manifest" {
        output = "manifest.json"
        strip_path = true
    }
}

EOF
}

# Check if all arguments are provided
if [ $# -ne 4 ]; then
    echo "Usage: $0 <output_file.pkr.hcl> <instance_type> <region> <os_version>"
    exit 1
fi

# Call the function to create Packer template file
create_packer_template "$1" "$2" "$3" "$4"