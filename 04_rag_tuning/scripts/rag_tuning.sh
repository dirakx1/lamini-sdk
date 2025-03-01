#!/bin/bash

# Safely execute this bash script
# e exit on first failure
# x all executed commands are printed to the terminal
# u unset variables are errors
# a export all variables to the environment
# E any trap on ERR is inherited by shell functions
# -o pipefail | produces a failure code if any stage fails
set -Eeuoxa pipefail

# Get the directory of this script
LOCAL_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Build the container
$LOCAL_DIRECTORY/../../scripts/build.sh

docker run -it \
    -v ~/.lamini:/root/.lamini \
    -v $LOCAL_DIRECTORY/../../data:/app/lamini-earnings-sdk/data \
    -v $LOCAL_DIRECTORY/../rag_model:/app/lamini-earnings-sdk/models \
    --entrypoint /app/lamini-earnings-sdk/04_rag_tuning/scripts/start.sh \
    lamini-earnings-sdk:latest $@
