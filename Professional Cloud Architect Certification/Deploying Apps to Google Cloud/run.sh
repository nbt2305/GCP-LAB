# Input REGION
if [[ -z "$REGION" ]]; then
    read -p "Input REGION: " REGION
fi

# Export env
export INPUT_ERROR="${RED}Errors: Please setup REGION env before run script.${RESET}"

# Check env
if [[ -z "$REGION" ]]; then
    echo -e $INPUT_ERROR
    exit 1
fi

export REGION

curl -LO raw.githubusercontent.com/QUICK-GCP-LAB/2-Minutes-Labs-Solutions/refs/heads/main/Deploying%20Apps%20to%20Google%20Cloud/shell.sh

sudo chmod +x shell.sh

./shell.sh