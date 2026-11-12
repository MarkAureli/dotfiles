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
zstyle ':omz:update' mode disabled  # updated at login by com.lennartbinkowski.omz-update LaunchAgent
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
ZSH_DISABLE_COMPFIX=true
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

# pyenv (PYENV_ROOT and shims on PATH are set in .zprofile)
# Lazy-load pyenv shell integration on first `pyenv` call
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init - zsh)"
  eval "$(command pyenv virtualenv-init -)"
  pyenv "$@"
}

# Set up direnv
eval "$(direnv hook zsh)"

# Autoload custom functions
for fn in "$DOTFILES"/functions/*(.N); do
  autoload -Uz "${fn:t}"
done

# Restrict completion 
zstyle ':completion:*:*:(less|nano|nvim|vim):*' ignored-patterns '*.pdf'

# bun completions
[ -s "/Users/lennartbinkowski/.bun/_bun" ] && source "/Users/lennartbinkowski/.bun/_bun"

