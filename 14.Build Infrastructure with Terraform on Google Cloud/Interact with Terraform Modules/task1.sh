#!/bin/bash

printf "$START" "1" "Build infrastructure"
# Init env
TASK_1=$(cat <<EOF
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  project = "$PROJECT_ID"
  region  = "$REGION"
  zone    = "$ZONE"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
EOF
)

### Task 1:
# Override main.tf
printf "%s\n" "$TASK_1" > main.tf

# Terraform Commands
terraform init
terraform apply --auto-approve

# End Step 1
printf "$END" "1"
printf "$CHECK" "1" "Check Creating Resources in terraform"
