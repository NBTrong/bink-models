#!/bin/bash

# Define the log file
LOG_FILE="./entrypoint.log"

echo "Starting ZeroTier" | tee -a $LOG_FILE
sudo zerotier-one -d > output.txt &

# Run python config.py
echo "Running config.py" | tee -a $LOG_FILE
python config.py | tee -a $LOG_FILE

# Read data.json, get the network ID
NETWORK_ID=$(python -c "import json; data = json.load(open('data.json')); print(data['network_id'])")
echo "Network ID: $NETWORK_ID" | tee -a $LOG_FILE

# Sleep for a few seconds to allow ZeroTier to start
sleep 5
# Join the network
echo "Joining Network" | tee -a $LOG_FILE
sudo zerotier-cli join $NETWORK_ID | tee -a $LOG_FILE

# Sleep for a few seconds to allow ZeroTier to join the network
sleep 10
sudo zerotier-cli listnetworks | tee -a $LOG_FILE

# Authorize the node
sleep 10
echo "Authorizing Node" | tee -a $LOG_FILE
python authorize.py | tee -a $LOG_FILE

# Sleep for a few seconds to allow ZeroTier to join the network
sleep 10
sudo zerotier-cli listnetworks | tee -a $LOG_FILE

# Get the IP address of the node
sleep 30
IP=$(sudo zerotier-cli listnetworks | grep 'bink-ai-vpn' | awk '{print $9}' | cut -d '/' -f1)
export NODE_IP_ADDRESS=$IP
echo "Node IP Address: $NODE_IP_ADDRESS" | tee -a $LOG_FILE

# Connect to the ray cluster
ray start --address=34.222.99.58:6379 --object-manager-port=8076 --node-ip-address=$NODE_IP_ADDRESS
tail -f /dev/null