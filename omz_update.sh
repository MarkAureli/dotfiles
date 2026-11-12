#!/bin/zsh
# Update oh-my-zsh non-interactively (run at login via LaunchAgent)

export ZSH="$HOME/.oh-my-zsh"
[[ -d $ZSH ]] || exit 0

# Wait for internet connectivity
MAX_WAIT=20
WAIT_INTERVAL=2
elapsed=0
while ! ping -q -c 1 -W 1 8.8.8.8 >/dev/null; do
    echo "No internet yet, waiting..."
    sleep $WAIT_INTERVAL
    elapsed=$((elapsed + WAIT_INTERVAL))
    if [[ $elapsed -ge $MAX_WAIT ]]; then
        echo "Timeout waiting for internet connection."
        exit 1
    fi
done

echo "[$(date)] Updating oh-my-zsh"
# upgrade.sh is non-interactive unless -i is passed; stdin closed so nothing can block
zsh "$ZSH/tools/upgrade.sh" -v minimal </dev/null
