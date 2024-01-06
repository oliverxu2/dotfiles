# vim: set filetype=bash:
#export TERM=xterm-256color
export PATH=~/.local/bin:$PATH

if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

export EDITOR=vim
export PAGER=less

export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden 2>/dev/null'

# Disable C-S and C-Q
if [[ -t 0 && $- = *i* ]]
then
  stty -ixoff -ixon
fi

export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
alias l='ls -alF'
alias ll='l -ltra'

#alias tmux='export TERM=screen-256color; /usr/local/bin/tmux'
alias tmux="tmux -2"
alias tmuxls="ls $TMPDIR/tmux*/"
alias k5='kill -9 %%'

PS1='\[\e[1;33m\][\u@\h \W \t]\$\[\e[0m\] '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
