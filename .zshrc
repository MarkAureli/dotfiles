# Disable alias hashing
setopt NO_HASH_CMDS

# Path to dotfiles.
export DOTFILES=$HOME/.dotfiles

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="apple"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Command execution time stamp shown in the history command output.
HIST_STAMPS="dd/mm/yyyy"

ZSH_CUSTOM=$DOTFILES
plugins=(git)
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Set up shell environment for pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export "PATH=$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Set up direnv
eval "$(direnv hook zsh)"

# Autoload custom functions
for fn in "$DOTFILES"/functions/*(.N); do
  autoload -Uz "${fn:t}"
done

# Local binary paths
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Restrict completion 
zstyle ':completion:*:*:(less|nano|nvim|vim):*' ignored-patterns '*.pdf'

export DEFAULT_BROWSER_BUNDLE_ID="$(
  plutil -extract LSHandlers json -o - \
    "$HOME/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist" 2>/dev/null |
  jq -r '
    [.[] | select(.LSHandlerURLScheme == "https" or .LSHandlerURLScheme == "http")
          | .LSHandlerRoleAll // .LSHandlerRoleViewer]
    | map(select(. != null))
    | last // empty
  '
)"

export DEFAULT_BROWSER_NAME="$(
  mdls -name kMDItemDisplayName -raw \
    "$(mdfind "kMDItemCFBundleIdentifier == '$DEFAULT_BROWSER_BUNDLE_ID'" | head -n 1)" \
    2>/dev/null
)"
