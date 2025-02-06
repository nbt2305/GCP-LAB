#!/bin/bash

echo "Tiếp tục thực hiện Step 1..."
gcloud auth list
gcloud config list project

# Đảm bảo các biến môi trường đã có giá trị
if [[ -z "$PROJECT_ID" || -z "$REGION" || -z "$ZONE" ]]; then
    echo "Lỗi: Vui lòng đặt biến môi trường PROJECT_ID, REGION, và ZONE trước khi chạy script."
    exit 1
fi

# Tạo và ghi đè nội dung vào file main.tf
cat > main.tf <<EOF
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

# Khởi tạo Terraform
terraform init
terraform apply --auto-approve

# Hỏi người dùng có muốn tiếp tục Step 2 không
read -p "Bạn có muốn tiếp tục Step 2? (y/Y để tiếp tục): " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    echo "Tiếp tục thực hiện Step 2..."
    
    # Ghi tiếp vào main.tf
    cat >> main.tf <<EOF

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
EOF

    # Áp dụng Terraform
    terraform apply --auto-approve
else
    echo "Quá trình bị hủy sau Step 1."
    exit 1
fi

# Hỏi người dùng có muốn tiếp tục Step 3 không
read -p "Bạn có muốn tiếp tục Step 3? (y/Y để tiếp tục): " confirm_step3

if [[ "$confirm_step3" == "y" || "$confirm_step3" == "Y" ]]; then
    echo "Tiếp tục thực hiện Step 3: Cập nhật boot_disk..."

    # Cập nhật boot_disk block bằng cách thay thế dòng trong main.tf
    sed -i '/boot_disk {/,/initialize_params {/{/image =/s|debian-cloud/debian-11|cos-cloud/cos-stable|}' main.tf

    # Kiểm tra thay đổi
    echo "Đã cập nhật boot_disk trong main.tf:"
    grep -A 3 "boot_disk" main.tf  # Hiển thị phần boot_disk mới để xác nhận

    # Áp dụng Terraform với thay đổi mới
    terraform apply --auto-approve
else
    echo "Quá trình bị hủy sau Step 2."
    exit 1
fi
