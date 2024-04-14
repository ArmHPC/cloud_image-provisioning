<a name="readme-top"></a>


<!-- ABOUT THE PROJECT -->
# Cloud Image Provisioning

This project makes use of tools like Packer, Terraform and Jupyter Notebook to present the user with a way of creating and deploying 
a new Amazon EC2 instance in a few clicks. The user can choose the OS version, Region and Type of the instance, as well as whether to
install Jupyter Notebook on the new instance or to run code remotely.

This can be useful for users that lack the resources but have the need to work with widely used tools such as Jupyter Notebook with languages like Python and R.

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

You will need:

* [Packer](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli)

* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

* [AWS Account](https://portal.aws.amazon.com/billing/signup?nc2=h_ct&src=default&redirect_url=https%3A%2F%2Faws.amazon.com%2Fregistration-confirmation#/start)

* [Local environment variables for your AWS account](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html#envvars-set)

You will also need:

* jq  
  ```sh
  sudo apt-get install jq
  ```


1. Clone the repo
   ```sh
   git clone https://github.com/ArmHPC/cloud_image-provisioning.git
   ```
2. Change into your cloned repo directory
   ```sh
   cd cloud_image-provisioning
   ```
3. Create a local SSH key
   ```sh
   ssh-keygen -t rsa -C "your_email@example.com" -f ./tf-packer
   ```


<!-- USAGE EXAMPLES -->
## Usage

Open `tf_packer.ipynb` in the `jupyter` directory.

Start running the cells and choosing from the available setup options.
After deploying the instance using Terraform:

1. Change directory
   ```sh
   cd cloud_image-provisioning/instances
   ```
2. Connect to the created instance via ssh
   ```sh
   ssh terraform@$(terraform output -raw public_ip) -i ./tf-packer
   ```
3. After finishing working on the instace, don't forget to destroy it to avoid any unwanted AWS charges
   ```sh
   terraform destroy
   ```


