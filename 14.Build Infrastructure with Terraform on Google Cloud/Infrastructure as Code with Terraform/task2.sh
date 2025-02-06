export TASK_2_STEP_1=$(cat <<EOF
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
)

export TASK_2_STEP_2=$(cat <<EOF
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
)

export TASK_2_STEP_3=$(cat <<EOF
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
)

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