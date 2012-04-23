# /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

HOST=`hostname`
KERNEL=`uname -r`
USERS=`users`
UPTIME=`uptime`
ADDR_IP=`echo -e "$SSH_CONNECTION" | awk '{print $1}'`
if [ "`id -u`" -eq 0 ]; then
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
else
  PATH="/usr/local/bin:/usr/bin:/bin:/usr/games"
fi

shopt -s checkwinsize
shopt -s histappend

clear
echo -e "\033[1;32m|-----------------------------------------------------------------|
| This system is for the use of authorized users only.            |
| Individuals using this computer system without authority, or in |
| excess of their authority, are subject to having all of their   |
| activities on this system monitored and recorded by system      |
| personnel.                                                      |
|                                                                 |
| In the course of monitoring individuals improperly using this   |
| system, or in the course of system maintenance, the activities  |
| of authorized users may also be monitored.                      |
|                                                                 |
| Anyone using this system expressly consents to such monitoring  |
| and is advised that if such monitoring reveals possible         |
| evidence of criminal activity, system personnel may provide the |
| evidence of such monitoring to law enforcement officials.       |
|-----------------------------------------------------------------|"
echo ""
echo -e "\033[1;31mW\e[1;32mi\e[1;33mt\e[1;34ma\e[1;35mj: \033[1;34m$USER \033[1;32mna serwerze\033[1;31m: $HOST"
echo ""
echo -e "\033[1;34mWersja Kernela: \033[1;33m$KERNEL"
echo -e "\033[1;34mZalogowani użytkownicy: \033[1;33m$USERS"
echo -e "\033[1;34mUptime: \033[1;33m$UPTIME"
echo -e "\033[1;34mTwoje ip to:\033[1;33m $ADDR_IP"
echo ""
PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;32m\]\H \[\033[01;33m\]: \[\033[01;34m\]\w \[\033[00m\]\] $ '
#PS1='[\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;32m\]\H\[\033[00m\]]\[\033[01;33m\] > \[\033[01;34m\]\w \[\033[00m\]\]$ '
PS2='> '
PS4='+ '
echo "Bledne proby logowan:"
if [ "`id -u`" -eq 0 ]; then
	grep --color=auto -E "Failed password" /var/log/auth*
fi
export PS1 PATH PS2 PS4
umask 022

# Aliasy
alias ls='ls -Flah --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias df='df -a -h -T'
alias du='du -a -h -c'
alias rmsvn='find . -name .svn -print0 | xargs -0 rm -rf'
alias test='netstat -apn | grep EST | grep 7172 | wc -l'
alias s='sensors'
alias upg='apt-get update && apt-file update && apt-get dist-upgrade && apt-get clean'
alias off='shutdown -h now'

export EDITOR=vim

declare -x LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.pdf=00;32:*.ps=00;32:*.txt=00;32:*.patch=00;32:*.diff=00;32:*.log=00;32:*.tex=00;32:*.doc=00;32:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"

export LESS='-R -M --shift 5'
export LESSOPEN='|lesspipe.sh %s'
export PAGER='/usr/bin/less'



alias wgets='wget --referer="http://www.google.com" --user-agent="Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6" --header="Accept:
text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" --header="Accept-Language: en-us,en;q=0.5" --header="Accept-Encoding: gzip,deflate"
--header="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" --header="Keep-Alive: 300"'
alias wget='wget -e robots=off'
alias ekg='export LANG="pl_PL.ISO-8859-2";screen -S ekg ekg'
alias rekg='export LANG="pl_PL.ISO-8859-2";screen -r ekg'
if [ $USER == "dulin" ]; then
alias irssi='export LANG=cp-1250;screen -S irc irssi'
alias rirssi='export LANG=cp-1250;screen -r irc'
fi 
# Developer Engine!
# Enable CCache

export CCACHE_DIR="/home/ccache"
export PATH=/usr/lib/ccache/:$PATH	
ccache -F 0 -M 8G -c &>/dev/null

# Get number cores
CORES=`grep processor /proc/cpuinfo | wc -l`
# Set make processes - 1 + number of cores
MAKEOPT=$(($CORES - 1))
alias make='make -j $MAKEOPT'
export CONCURRENCY_LEVEL=$MAKEOPT
#test -x /usr/bin/check-sendfile && /usr/bin/check-sendfile || /bin/true
