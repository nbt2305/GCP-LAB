# Input REGION_1
if [[ -z "$REGION_1" ]]; then
    read -p "Input REGION_1: " REGION_1
fi

# Input REGION_2
if [[ -z "$REGION_2" ]]; then
    read -p "Input REGION_2: " REGION_2
fi

# Input REGION_3
if [[ -z "$REGION_3" ]]; then
    read -p "Input REGION_3: " REGION_3
fi

# Export env
export INPUT_ERROR="${RED}Errors: Please setup REGION_1, REGION_2, REGION_3 env before run script.${RESET}"

# Check env
if [[ -z "$REGION_1" || -z "$REGION_2" || -z "$REGION_3"]]; then
    echo -e $INPUT_ERROR
    exit 1
fi

export REGION_1 REGION_2 REGION_3

gcloud config set compute/zone "us-east4-a"
export ZONE=$(gcloud config get compute/zone)

gcloud config set compute/region "us-east4"
export REGION=$(gcloud config get compute/region)

gcloud compute networks create taw-custom-network --subnet-mode custom

gcloud compute networks subnets create subnet-$REGION_1 --network taw-custom-network --region $REGION_1 --range 10.0.0.0/16

gcloud compute networks subnets create subnet-$REGION_2 --network taw-custom-network --region $REGION_2 --range 10.1.0.0/16

gcloud compute networks subnets create subnet-$REGION_3 --network taw-custom-network --region $REGION_3 --range 10.2.0.0/16

gcloud compute networks subnets list --network taw-custom-network

gcloud compute firewall-rules create nw101-allow-http --allow tcp:80 --network taw-custom-network --source-ranges 0.0.0.0/0 --target-tags http

gcloud compute firewall-rules create "nw101-allow-icmp" --allow icmp --network "taw-custom-network" --target-tags rules

gcloud compute firewall-rules create "nw101-allow-internal" --allow tcp:0-65535,udp:0-65535,icmp --network "taw-custom-network" --source-ranges "10.0.0.0/16","10.2.0.0/16","10.1.0.0/16"

gcloud compute firewall-rules create "nw101-allow-ssh" --allow tcp:22 --network "taw-custom-network" --target-tags "ssh"

gcloud compute firewall-rules create "nw101-allow-rdp" --allow tcp:3389 --network "taw-custom-network"