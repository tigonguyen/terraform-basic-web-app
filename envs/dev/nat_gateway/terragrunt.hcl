############ Terragrunt section #############
# Get configuration from root directory
include {
    path = find_in_parent_folders()
}

############ Terraform section ##############
# Use remote module for configuration
terraform {
  source = "../../../modules/aws_nat_gateway"
}

# Collect values from env_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

# Define dependencies on other modules
dependency "vpc" {
  config_path = "../vpc"
}
dependency "subnets" {
  config_path = "../subnets"
}
# To ensure proper ordering, it is recommended to add an explicit dependency
# on the Internet Gateway for the VPC.
dependency "internet_gateway" {
  config_path = "../internet_gateway"
}

# Pass data into remote module with inputs
inputs = {
  public_a_id = dependency.subnets.outputs.public_a_id
  public_b_id = dependency.subnets.outputs.public_b_id
  env         = local.env_vars.env
}