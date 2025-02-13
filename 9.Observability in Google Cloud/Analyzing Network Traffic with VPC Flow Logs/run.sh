if [[ -z "$ZONE" ]]; then
    echo -e $INPUT_ERROR
    exit 1
fi

export ZONE

curl -LO raw.githubusercontent.com/Techcps/GSP/master/Analyzing%20Network%20Traffic%20with%20VPC%20Flow%20Logs/techcps.sh
sudo chmod +x techcps.sh
./techcps.sh