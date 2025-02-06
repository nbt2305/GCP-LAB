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