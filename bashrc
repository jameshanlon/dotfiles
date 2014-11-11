# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Commands
alias ls='ls --color=auto -h'
alias ll='ls -alFH'
alias lr='ls -R'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep -I'
alias rgrep='grep -r'

export GREP_OPTIONS="-n --color"

# Terminal
export TERM=xterm-256color

# Prompt (w/ git prompt)
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="auto"
source ~/.git-prompt.sh
GREEN="\[\033[01;32m\]"
BLUE="\[\033[0;34m\]"
NOCOLOUR="\[\033[0m\]"
TITLE='\[\033]0;\u@\h:\w\007\]'
PS1="$TITLE$GREEN\u@\h$NOCOLOUR "'\W$(__git_ps1 "[%s]")'"\n\$ "

