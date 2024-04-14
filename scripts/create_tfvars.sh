#!/bin/bash

# Function to create a tfvars file
create_tfvars_file() {
    cat << EOF > ../instances/terraform.tfvars
region = "$1"
ami_id = "$2"
inst_type = "$3"
EOF
}

# Check if all arguments are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <region> <ami_id> <instance_type>"
    exit 1
fi

# Call the function to create tfvars file
create_tfvars_file "$1" "$2" "$3"