gcloud config set compute/zone "us-east4-a"
export ZONE=$(gcloud config get compute/zone)

gcloud config set compute/region "us-east4"
export REGION=$(gcloud config get compute/region)

gcloud compute networks create taw-custom-network --subnet-mode custom

gcloud compute networks subnets create subnet-us-east4 --network taw-custom-network --region us-east4 --range 10.0.0.0/16

gcloud compute networks subnets create subnet-europe-west1 --network taw-custom-network --region europe-west1 --range 10.1.0.0/16

gcloud compute networks subnets create subnet-us-east1 --network taw-custom-network --region us-east1 --range 10.2.0.0/16

gcloud compute networks subnets list --network taw-custom-network

gcloud compute firewall-rules create nw101-allow-http --allow tcp:80 --network taw-custom-network --source-ranges 0.0.0.0/0 --target-tags http

gcloud compute firewall-rules create "nw101-allow-icmp" --allow icmp --network "taw-custom-network" --target-tags rules

gcloud compute firewall-rules create "nw101-allow-internal" --allow tcp:0-65535,udp:0-65535,icmp --network "taw-custom-network" --source-ranges "10.0.0.0/16","10.2.0.0/16","10.1.0.0/16"

gcloud compute firewall-rules create "nw101-allow-ssh" --allow tcp:22 --network "taw-custom-network" --target-tags "ssh"

gcloud compute firewall-rules create "nw101-allow-rdp" --allow tcp:3389 --network "taw-custom-network"