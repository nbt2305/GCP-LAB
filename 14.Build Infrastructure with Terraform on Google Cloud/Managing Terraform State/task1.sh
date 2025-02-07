#!/bin/bash

printf "$START" "1" "Working with backends"
# Init env
TASK_1_STEP_1=$(cat <<EOF
provider "google" {
  project     = "$PROJECT_ID"
  region      = "us-central1"
}

resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "$PROJECT_ID"
  location    = "US"
  uniform_bucket_level_access = true
}

terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}
EOF
)

TASK_1_STEP_2=$(cat <<EOF
provider "google" {
  project     = "$PROJECT_ID"
  region      = "us-central1"
}

resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "$PROJECT_ID"
  location    = "US"
  uniform_bucket_level_access = true
}

terraform {
  backend "gcs" {
    bucket  = "$PROJECT_ID"
    prefix  = "terraform/state"
  }
}
EOF
)

### Task 1:
# Override main.tf
printf "%s\n" "$TASK_1_STEP_1" > main.tf

# Terraform Commands
terraform init
terraform apply --auto-approve

# Override main.tf
printf "%s\n" "$TASK_1_STEP_2" > main.tf

# Terraform Commands
terraform init
terraform apply --auto-approve
printf "$END_STEP" "1" "2" "Add Labels and Check Refresh the state"

# End Step 1
printf "$END" "1"
printf "$CHECK" "1" "Check Refresh the state"
