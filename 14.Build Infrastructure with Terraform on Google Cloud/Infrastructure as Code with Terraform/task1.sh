# Task 1
export TASK_1=$(cat <<EOF
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
printf "$START" "1" "Build infrastructure"
# Override main.tf file
echo $TASK_1 > main.tf
# Terraform Command
terraform init
terraform apply --auto-approve
printf "$END" "1"