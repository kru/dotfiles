
plugins=(git fasd)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

eval "$(fasd --init auto)"

# Enable persistent history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS

# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS

alias zshrefresh='source ~/.zshrc'
alias gitlocaluser='git config --local credential.helper ""'
alias z='fasd_cd -d'
alias vim='nvim'
alias vi='/usr/bin/vim'
alias gosleep='sudo shutdown -s now'
alias tldr='~/Downloads/tldr'
# alias ls='ls -l'
#alias python='python3'


export GOPATH=$HOME/go
export PATH=$PATH:$HOME/go/bin
# export GPG_TTY=$(tty)


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
export PATH="$PATH:$HOME/helix-25.01.1-x86_64-macos"
export PATH="$PATH:$HOME/github.com/ols"
export PATH="$PATH:$HOME/Odin"
export ODIN_ROOT="$HOME/Odin"
export PATH="$PATH:$HOME/github.com/kru/eztracker"
