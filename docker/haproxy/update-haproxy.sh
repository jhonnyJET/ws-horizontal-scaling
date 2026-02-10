#!/bin/sh

SOCKET="/var/run/haproxy/admin.sock"

# 1. Wait for Socket (Keep this, it's working!)
echo "Checking for HAProxy socket..."
while [ ! -S "$SOCKET" ]; do
    echo "Socket not found yet. Waiting 1s..."
    sleep 1
done

# 2. Read the new list of IPs
NEW_IPS=$(cat /tmp/hosts.map)
i=1

# 3. Loop through the IPs
for full_addr in $NEW_IPS; do
    # --- FIX: SPLIT IP AND PORT ---
    # Extract IP (remove everything after the colon)
    IP=${full_addr%:*}
    # Extract Port (remove everything before the colon)
    PORT=${full_addr#*:}
    
    echo "Setting slot s$i to IP: $IP Port: $PORT"
    
    # --- FIX: SEND IP AND PORT SEPARATELY ---
    # Syntax: set server <backend>/<server> addr <ip> port <port>
    echo "set server websockets/s$i addr $IP port $PORT" | socat stdio $SOCKET
    
    # Enable the slot
    echo "enable server websockets/s$i" | socat stdio $SOCKET
    
    i=$((i+1))
done

# 4. Disable unused slots
while [ $i -le 10 ]; do
    echo "disable server websockets/s$i" | socat stdio $SOCKET
    i=$((i+1))
done