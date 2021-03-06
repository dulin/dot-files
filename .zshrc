# Load the completions stuff
source ~/.nvm/nvm.sh
autoload -U compinit
compinit

# Load the prompt stuff
autoload -U promptinit
promptinit

# History settings
HISTFILE=~/.zshistory
SAVEHIST=3000
HISTSIZE=3000 # should be enough
DIRSTACKSIZE=30

function parse_git_dirty {
	git diff --no-ext-diff --quiet --exit-code &> /dev/null || echo "*"
}

function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}


# ZSH Options
setopt promptsubst
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups # push directories visited automatically onto stack
setopt autocd # auto cd to directories
setopt globdots # find dotfiles easier
setopt histreduceblanks
setopt histignorespace # don't put spaces to history file
setopt histignorealldups
setopt SH_WORD_SPLIT # passes "foo bar" as "foo" "bar" to commands. Backward compatibility with sh/ksh
setopt automenu # Automatically use menu completion after the second consecutive request for completion, for example by pressing the TAB key repeatedly
setopt cdablevars # avoid the need for an explicit $
setopt nohup # and don't kill them, either
setopt listpacked # compact completion lists
setopt nolisttypes # show types in completion
setopt extendedglob # weird & wacky pattern matching - yay zsh!
setopt completeinword # not just at the end
setopt alwaystoend # when complete from middle, move cursor
setopt correct # spelling correction
setopt nopromptcr # don't add \n which overwrites cmds with no \n
unsetopt promptcr
setopt histverify # when using ! cmds, confirm first
setopt interactivecomments # escape commands so i can use them later
setopt printexitvalue # alert me if something's failed

setopt HASH_CMDS
setopt HASH_DIRS
setopt NUMERIC_GLOB_SORT
setopt appendhistory beep nomatch
setopt PRINT_EXIT_VALUE
setopt SHARE_HISTORY # share history between open shells
setopt MARK_DIRS # adds slash to end of completed dirs
setopt INC_APPEND_HISTORY # append history as command are entered
setopt HIST_NO_STORE # don't save 'history' cmd in history

# Useful pipe shortcuts
bindkey -s '^|l' " | less\n" # c-| l pipe to less
bindkey -s '^|g' ' | grep ""^[OD' # c-| g pipe to grep
bindkey -s '^|a' " | awk '{print $}'^[OD^[OD" # c-| a pipe to awk
bindkey -s '^|s' ' | sed -e "s///g"^[OD^[OD^[OD^[OD' # c-| s pipe to sed
bindkey -s '^|w' " | wc -l\n" # c-| w pipe to wc

# search history on <up> key instead of paging previous commands:
bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward

# Colours
local red="%{"$'\e[1;31m'"%}"
local RED="%{"$'\e[0;31m'"%}"
local cyan="%{"$'\e[1;36m'"%}"
local CYAN="%{"$'\e[0;36m'"%}"
local blue="%{"$'\e[1;34m'"%}"
local BLUE="%{"$'\e[0;34m'"%}"
local green="%{"$'\e[1;32m'"%}"
local GREEN="%{"$'\e[0;32m'"%}"
local magenta="%{"$'\e[1;35m'"%}"
local MAGENTA="%{"$'\e[0;35m'"%}"
local yellow="%{"$'\e[1;33m'"%}"
local YELLOW="%{"$'\e[0;33m'"%}"
local gray="%{"$'\e[1;30m'"%}"
local GRAY="%{"$'\e[0;37m'"%}"
local white="%{"$'\e[1;37m'"%}"
local NOCOLOR="%{"$'\e[0m'"%}"
local NEWLINE="%{"$'\e[80D'"%}"

# Prompt
export PS1="${GREY}[${red}%n${yellow}@${GREEN}%m:${blue}%~/${GRAY}]${red}% $CYAN\$(parse_git_branch)$MAGENTA#$NOCOLOR "
#export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\]\033[01;36m\]\w\[\033[00m\]\$(parse_git_branch
#export PS1="${GRAY}[${GREEN}%n@%m:%~/${GRAY}]${RED}%#$NOCOLOR "
export PS2="%_> "
export RPS1=""

# Emacs key bindings
bindkey -e

# For zsh to work well within Emacs
[[ $EMACS = t ]] && unsetopt zle

# ENV
export PAGER=/usr/bin/less
export PATH=~/bin:$PATH

# Completion styles
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort access
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' '+m:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:::::' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 2
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete # Completion caching
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST # Expand partial paths
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes' # Include non-hidden directories in globbed file completions
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~' # Separate matches into groups
zstyle ':completion:*:matches' group 'yes' # Describe each match group.
zstyle ':completion:*:descriptions' format "%B---- %d%b" # Messages/warnings format
zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b' # Describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# Aliases
alias psaux='ps aux'
alias cl='clear'
alias c=cl
alias cls=cl
alias mv='nocorrect mv -i' # no spelling correction on mv
alias cp='nocorrect cp' # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias vi='vim' # Vi IMproved
alias rm='nocorrect rm -i' # interactive RM
alias ls="ls -Flah --color"
alias df='df -a -h -T'
alias du='du -a -h -c'
alias rmsvn='find . -name .svn -print0 | xargs -0 rm -rf'
alias rmgit='find . -name .git -print0 | xargs -0 rm -rf'
alias gc='git clone'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias clls="clear;ls -Glah --color"
alias ping='ping -c 4 '
alias pingg='ping -c 4 www.google.com'
alias git-sh='nocorrect ~/bin/git-sh'
alias ekg='export LANG="pl_PL.ISO-8859-2";screen -S ekg ekg'
alias rekg='export LANG="pl_PL.ISO-8859-2";screen -r ekg'
alias irssi='export LANG=cp-1250;screen -S irc irssi'
alias rirssi='export LANG=cp-1250;screen -r irc'

# Utility function
export EDITOR=vim
pskill()
{
kill -9 $(ps -aux | grep $1 | grep -v grep | awk '{ print $1 }')
echo -n "Killed $1 process..."
}

function precmd {
    rehash
}

case $TERM in
xterm*|rxvt|(K|a)term)
precmd () {
print -Pn "\033]0;%n@%m%# %~ %l %w :: %T\a"
}
preexec () {
print -Pn "\033]0;%n@%m%# <$1> %~ %l %w :: %T\a"
}
;;
esac

umask 022



export PATH=~/.linuxbrew/bin:$PATH
export LD_LIBRARY_PATH=~/.linuxbrew/lib

[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
