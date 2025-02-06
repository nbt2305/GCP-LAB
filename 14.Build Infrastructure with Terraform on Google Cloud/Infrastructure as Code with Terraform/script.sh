#!/bin/bash

### Input env
# Input PROJECT_ID
if [[ -z "$PROJECT_ID" ]]; then
    read -p "Nhập PROJECT_ID: " PROJECT_ID
fi

# Input REGION
if [[ -z "$REGION" ]]; then
    read -p "Nhập REGION: " REGION
fi

# Input ZONE
if [[ -z "$ZONE" ]]; then
    read -p "Nhập ZONE: " ZONE
fi

# Export env
export PROJECT_ID REGION ZONE
export START="Starting Task %s..."
export END="Congratulations complete Task %s!"
export CANCEL="Proccess is canceled after Task %S."
export PROMPT_TEMPLATE="Do you want to continue Task %s? (y/Y to continue): "

### Task 1:
printf "$START" "1"
gcloud auth list
gcloud config list project

# Check env
if [[ -z "$PROJECT_ID" || -z "$REGION" || -z "$ZONE" ]]; then
    echo "Errors: Please setup PROJECT_ID, REGION, ZONE env before run script."
    exit 1
fi

printf "$START" "2"
# Create and override content into main.tf file
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

# Terraform Init
terraform init
terraform apply --auto-approve
printf "$END" "1"

### Task 2:
read -p "$(printf "$PROMPT_TEMPLATE" "2")" confirm2

if [[ "$confirm2" == "y" || "$confirm2" == "Y" ]]; then
    printf "$START" "2"
    
    # Override main.tf
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

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  tags         = ["web", "dev"]

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
    printf "$END" "2"
else
    printf "$CANCLE" "2"
    exit 1
fi

### Task 3:
read -p "$(printf "$PROMPT_TEMPLATE" "3")" confirm3

if [[ "$confirm3" == "y" || "$confirm3" == "Y" ]]; then
    printf "$START" "3"

    cat > main.tf << EOF
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

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
EOF
    terraform apply --auto-approve
    terraform destroy --auto-approve
    printf "$END" "3"
else
    printf "$CANCLE" "3"
    exit 1
fi

### Task 4:
read -p "$(printf "$PROMPT_TEMPLATE" "4")" confirm4

if [[ "$confirm4" == "y" || "$confirm4" == "Y" ]]; then
    printf "$START" "4"

    cat > main.tf << EOF
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

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }
  resource "google_compute_address" "vm_static_ip" {
    name = "terraform-static-ip"
  }
}
EOF
    terraform plan -out static_ip
    terraform apply "static_ip" --auto-approve
    printf "$END" "4"
else
    printf "$CANCLE" "4s"
    exit 1
fi
