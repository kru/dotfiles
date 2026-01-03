### ZSH HOME
source ~/.zsh/themes/minimal.zsh

# Show asterisk when working tree is dirty (modified/staged/untracked)
MNML_GIT_DIRTY_MARK='*'
MNML_GIT_CLEAN_MARK=''

# Left-aligned components on upper line: current directory basename + Git branch/status
MNML_PROMPT=('mnml_cwd 1 0' mnml_git)

# No right-side or additional components
MNML_RPROMPT=()
MNML_INFOLN=()

# Two-line prompt with reliable newline handling to prevent overlap
PROMPT='${prompt_newline}%{%(?.%F{green}.%F{red})%}➤ %{%f%}'

# Enable prefix-based history search with up/down arrows (exact Oh My Zsh style)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Bind to standard arrow keys (works in most terminals)
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search   # Up arrow
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search # Down arrow

# Fallback bindings if terminfo is unavailable (common on macOS/iTerm)
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Basic LS_COLORS (adjust as preferred)
export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=32:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

# Initialize completion system (if not already done)
autoload -Uz compinit
compinit

# Enable colored completion menu
zstyle ':completion:*' list-colors ''

# Define color styles for different completion types (LS_COLORS style)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Optional: Enhance menu selection for better visibility
zstyle ':completion:*' menu select  # Interactive menu with arrow navigation
zstyle ':completion:*' group-name ''  # Group matches by type
zstyle ':completion:*:*:*:*:*' menu yes select  # Always use menu selection


# You may need to manually set your language environment
export LANG=en_US.UTF-8

eval "$(fasd --init auto)"

# Enable persistent history
HISTFILE=~/.zsh/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS

# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS

alias zshrefresh='source ~/.zsh/.zshrc'
alias gitlocaluser='git config --local credential.helper ""'
alias z='fasd_cd -d'
alias vim='nvim'
alias vi='/usr/bin/vim'
alias gosleep='sudo shutdown -s now'
alias tldr='~/Downloads/tldr'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'


export GOPATH=$HOME/go
export PATH=$PATH:$HOME/go/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export LC_ALL="en_US.UTF-8"

export PATH="$PATH:$HOME/cosmocc/bin"
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$HOME/ispc-v1.25.1-macOS.x86_64/bin"
export PATH="$PATH:$HOME/github.com/ols"
export PATH="$PATH:$HOME/Odin"
export ODIN_ROOT="$HOME/Odin"
export PATH="$PATH:$HOME/github.com/kru/eztracker"
