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