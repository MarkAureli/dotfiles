#!/bin/zsh

# Wait for internet connectivity
MAX_WAIT=20
WAIT_INTERVAL=2
elapsed=0

if command -v brew &>/dev/null; then
    while ! ping -q -c 1 -W 1 8.8.8.8 >/dev/null; do
        echo "No internet yet, waiting..."
        sleep $WAIT_INTERVAL
        elapsed=$((elapsed + WAIT_INTERVAL))
        if [[ $elapsed -ge $MAX_WAIT ]]; then
            echo "Timeout waiting for internet connection."
            exit 1
        fi
    done
    brew update
    brew upgrade
    brew cleanup
fi

