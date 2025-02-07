#!/bin/bash

### Input colors
RED='\033[0;31m'        # RED - ERRORS
GREEN='\033[0;32m'      # GREEN - SUCCESS
YELLOW='\033[0;33m'     # YELLOW - WARNING
BLUE='\033[0;34m'       # BLUE - PROCESSING
MAGENTA='\033[0;35m'    # MAGENTA - FOCUS
CYAN='\033[0;36m'       # CYAN - ASK
RESET='\033[0m'         # RESET - RESET
### Input env
# Input REGION
if [[ -z "$REGION" ]]; then
    read -p "Input REGION: " REGION
fi

# Export env
export INPUT_ERROR="${RED}Errors: Please setup REGION env before run script.${RESET}"
export START="${BLUE}Starting Task %s: %s...${RESET}\n"
export START_STEP="${BLUE}Starting Task %s - Step %s: %s...${RESET}\n"
export CHECK_STEP="${YELLOW}Please check Task %s - Step %s: %s...${RESET}\n"
export CHECK="${YELLOW}Please check Task %s: %s...${RESET}\n"
export END="${GREEN}Congratulations complete Task %s!${RESET}\n"
export END_STEP="${GREEN}Congratulations complete Task %s - Step %s!${RESET}\n"
export CANCEL="${RED}Process is canceled after Task %s.${RESET}\n"
export PROMPT_TEMPLATE="${CYAN}Do you want to continue Task %s? (y/Y to continue): ${RESET}"
export PROMPT_TEMPLATE_STEP="${CYAN}Do you want to continue Task %s - Step %s? (y/Y to continue): ${RESET}"
export PROJECT_ID=$(gcloud config list --format 'value(core.project)')

gcloud auth list
gcloud config list project