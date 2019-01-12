# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Commands
alias ls='ls --color=auto -h'
alias ll='ls -alFH'
alias lt='ls -ltr'
alias lr='ls -R'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias rgrep='grep -r --color=auto'
alias vim='nvim'
alias v='vim'
alias h='history'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'

# Environment
export EDITOR=nvim
export GREP_COLOR="1;33"
export TERM=xterm-256color

# Key bindings
# http://www.gnu.org/software/bash/manual/html_node/Commands-For-Killing.html#Commands-For-Killing
bind '"\C-w": shell-kill-word' # Delete next word

# Prompt (w/ git prompt)
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="auto"
source $HOME/.git-prompt.sh
GREEN="\[\033[01;32m\]"
BLUE="\[\033[0;34m\]"
NOCOLOUR="\[\033[0m\]"
TITLE='\[\033]0;\u@\h:\w\007\]'
PS1="$TITLE$GREEN\u@\h$NOCOLOUR "'\W$(__git_ps1 "[%s]")'"\n\$ "

# git completion
source $HOME/.git-completion.bash

# fzf
source $HOME/.fzf.bash

# pet
function prev() {
PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}
function pet-select() {
  BUFFER=$(pet search --query "$READLINE_LINE")
  READLINE_LINE=$BUFFER
  READLINE_POINT=${#BUFFER}
}
bind -x '"\C-p": pet-select'

# Eternal bash history
# --------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s histappend
stophistory () {
  PROMPT_COMMAND="bash_prompt_command"
  echo 'History recording stopped. Make sure to `kill -9 $$` at the end of the session.'
}
