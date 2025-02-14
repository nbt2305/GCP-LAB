# Input REGION_1
if [[ -z "$REGION_1" ]]; then
    read -p "Input REGION_1: " REGION_1
fi

# Export env
export INPUT_ERROR="${RED}Errors: Please setup REGION_1 env before run script.${RESET}"

# Check env
if [[ -z "$REGION_1" ]]; then
    echo -e $INPUT_ERROR
    exit 1
fi

# Input REGION_2
if [[ -z "$REGION_2" ]]; then
    read -p "Input REGION_2: " REGION_2
fi

# Export env
export INPUT_ERROR="${RED}Errors: Please setup REGION_2 env before run script.${RESET}"

# Check env
if [[ -z "$REGION_2" ]]; then
    echo -e $INPUT_ERROR
    exit 1
fi

# Input REGION_3
if [[ -z "$REGION_3" ]]; then
    read -p "Input REGION_3: " REGION_3
fi

# Export env
export INPUT_ERROR="${RED}Errors: Please setup REGION_3 env before run script.${RESET}"

# Check env
if [[ -z "$REGION_3" ]]; then
    echo -e $INPUT_ERROR
    exit 1
fi

export REGION_1 REGION_2 REGION_3

curl -LO raw.githubusercontent.com/QUICK-GCP-LAB/2-Minutes-Labs-Solutions/main/Networking%20101/gsp016.sh

sudo chmod +x gsp016.sh

./gsp016.sh