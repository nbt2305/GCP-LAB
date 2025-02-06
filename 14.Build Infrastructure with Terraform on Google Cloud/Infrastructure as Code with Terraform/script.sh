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

# Input UNIQUE_BUCKET_NAME
if [[ -z "$UNIQUE_BUCKET_NAME" ]]; then
    read -p "Nhập UNIQUE_BUCKET_NAME: " UNIQUE_BUCKET_NAME
fi

# Export env
export PROJECT_ID REGION ZONE UNIQUE_BUCKET_NAME
export START="Starting Task %s: %s...\n"
export START_STEP="Starting Task %s - Step %s...\n"
export END="Congratulations complete Task %s!\n"
export END_STEP="Congratulations complete Task %s - Step %s!\n"
export CANCEL="Proccess is canceled after Task %s.\n"
export PROMPT_TEMPLATE="Do you want to continue Task %s? (y/Y to continue): "
export PROMPT_TEMPLATE_STEP="Do you want to continue Task %s - Step %s? (y/Y to continue): "
# Task 1
export TASK_1="terraform {
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
}"
export TASK_2_STEP_1="terraform {
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
}"
export TASK_2_STEP_2="terraform {
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
}"

export TASK_2_STEP_3="terraform {
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
}"
export TASK_3_STEP_1="terraform {
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
}
resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}"

export TASK_3_STEP_2="terraform {
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
}
resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}
# New resource for the storage bucket our application will use.
resource "google_storage_bucket" "example_bucket" {
  name     = "$UNIQUE_BUCKET_NAME>"
  location = "US"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

# Create a new instance that uses the bucket
resource "google_compute_instance" "another_instance" {
  # Tells Terraform that this VM instance must be created only after the
  # storage bucket has been created.
  depends_on = [google_storage_bucket.example_bucket]

  name         = "terraform-instance-2"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}"

gcloud auth list
gcloud config list project

# Check env
if [[ -z "$PROJECT_ID" || -z "$REGION" || -z "$ZONE" ]]; then
    echo "Errors: Please setup PROJECT_ID, REGION, ZONE env before run script."
    exit 1
fi

### Task 1:
printf "$START" "1" "Build infrastructure"
# Override main.tf file
echo $TASK_1 > main.tf
# Terraform Command
terraform init
terraform apply --auto-approve
printf "$END" "1"

### Task 2:
read -p "$(printf "$PROMPT_TEMPLATE" "2")" confirm2
printf "$START" "2" "Change infrastructure"

if [[ "$confirm2" == "y" || "$confirm2" == "Y" ]]; then
    printf "$START" "2" "Change infrastructure"
    ## Step 1
    printf "$START_STEP" "1" "2"
    # Override main.tf
    cat $TASK_2_STEP_1 > main.tf
    # Terraform Command
    terraform apply --auto-approve
    printf "$END_STEP" "2" "1"

    ## Step 2
    read -p "$(printf "$PROMPT_TEMPLATE_STEP" "2" "2")" confirm2_2
    if [[ "$confirm2_2" == "y" || "$confirm2_2" == "Y" ]]; then
        printf "$START_STEP" "2" "2"
        # Override main.tf
        cat $TASK_2_STEP_2 > main.tf
        # Terraform Command
        terraform apply --auto-approve
        printf "$END_STEP" "2" "2"

    ## Step 3
    read -p "$(printf "$PROMPT_TEMPLATE_STEP" "2" "2")" confirm2_3
    if [[ "$confirm2_3" == "y" || "$confirm2_3" == "Y" ]]; then
        printf "$START_STEP" "2" "3"
        # Override main.tf
        cat $TASK_2_STEP_3 > main.tf
        # Terraform Command
        terraform destroy --auto-approve
        printf "$END_STEP" "2" "3"
else
    printf "$CANCLE" "2"
    exit 1
fi

### Task 3:
read -p "$(printf "$PROMPT_TEMPLATE" "3")" confirm3
printf "$START" "3" "Create resource dependencies"
if [[ "$confirm3" == "y" || "$confirm3" == "Y" ]]; then
    printf "$START" "3"
    # Terraform Command
    terraform apply --auto-approve
    read -p "$(printf "$PROMPT_TEMPLATE_STEP" "3" "1")" confirm3_1
    if [[ "$confirm3_1" == "y" || "$confirm3_1" == "Y" ]]; then
        cat $TASK_3_STEP_1 > main.tf
        terraform plan -out static_ip
        terraform apply "static_ip"
        printf "$END_STEP" "3" "1"
    if [[ "$confirm3_2" == "y" || "$confirm3_2" == "Y" ]]; then
        cat $TASK_3_STEP_2 > main.tf
        terraform apply --auto-approve
        printf "$END_STEP" "3" "2"
    printf "$END" "3"
else
    printf "$CANCLE" "3"
    exit 1
fi