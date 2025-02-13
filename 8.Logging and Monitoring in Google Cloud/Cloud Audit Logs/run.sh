# Input ZONE
if [[ -z "$ZONE" ]]; then
    read -p "Input ZONE: " ZONE
fi

# Export env
export INPUT_ERROR="${RED}Errors: Please setup ZONE env before run script.${RESET}"

# Check env
if [[ -z "$ZONE" ]]; then
    echo -e $INPUT_ERROR
    exit 1
fi

export ZONE

curl -LO raw.githubusercontent.com/Techcps/Google-Cloud-Skills-Boost/master/Cloud%20Audit%20Logs/techcps.sh
sudo chmod +x techcps.sh
./techcps.sh