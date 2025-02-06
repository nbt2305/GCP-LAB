#!/bin/bash

# In thông báo bắt đầu Step 1
printf "$START" "1" "Build infrastructure"

printf "Helloooo!!!\n"

# Task 1: Gán nội dung vào biến TASK_1 và giữ đúng định dạng
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
# Ghi nội dung vào main.tf (Dùng printf để giữ đúng định dạng)
printf "%s\n" "$TASK_1" > main.tf

# Terraform Commands
terraform init
terraform apply --auto-approve

# In thông báo kết thúc Step 1
printf "$END" "1"
