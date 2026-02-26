#!/bin/zsh

DOTFILES_DIR="${HOME}/.dotfiles"

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

if [[ ! -d "${DOTFILES_DIR}/.git" ]]; then
    echo "Not a git repository: ${DOTFILES_DIR}"
    exit 1
fi

cd "${DOTFILES_DIR}" || exit 1

# Load SSH key from macOS keychain
ssh-add --apple-load-keychain 2>/dev/null

git fetch --quiet origin 2>&1
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse @{u} 2>/dev/null)

if [[ -z "$REMOTE" ]]; then
    echo "No upstream branch configured, skipping sync."
    exit 0
fi

if [[ "$LOCAL" == "$REMOTE" ]]; then
    echo "Dotfiles already up to date."
    exit 0
fi

git pull --rebase --autostash 2>&1
echo "Dotfiles synced."
