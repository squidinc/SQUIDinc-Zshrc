##
## .zshrc
##

# ========================
#       ENVIRONMENT
# ========================
setopt ALL_EXPORT

path=( {/usr{/local,},}/{bin,sbin} /Applications/Xcode.app/Contents/Developer/{Tools,usr/bin} /usr/libexec )

export MANPATH=/usr/local/share/man:/usr/share/man:/Developer/usr/share/man
export INFOPATH=/usr/share/info
export CDPATH=$HOME:/Volumes:$HOME/.zfunc:$HOME/Library:$HOME/Library/Application\ Support:/Library:/Code

export HISTFILE=$HOME/.zhist
export SSLKEYLOGFILE=$HOME/.sslkeylogfile.txt

# TODO: Add support for backing up the history file when it becomes too large.
#		Maybe this should be a daily periodic LaunchDaemon.  Also, before
#		recompressing the archive, consider removing duplicate lines...
#		(1) sort
#		(2) uniq -ds 15
#		(3) 

export HISTSIZE=$((2*2**30-1))      #2147483647 #65535
export SAVEHIST=$((HISTSIZE-5000))  #2147478647 #65035
export DIRSTACKSIZE=25
# export PROMPT='(%D{%I:%M:%S%p}) %(2L:%L :)%n %3~%# '	# PROMPT='(%U%D{%I:%M:%S %p}%u) %U%(2L:%L :)%u%(2L: :)%U%n%u %U%3~%u%# '
export PROMPT=$'%{\e[0m%}%{\e[90m%}(%D{%I:%M:%S%p}) %(2L:%L :)%n %3~%# %{\e[0m%}'	# PROMPT='(%U%D{%I:%M:%S %p}%u) %U%(2L:%L :)%u%(2L: :)%U%n%u %U%3~%u%# '

# export CC=/Developer/usr/bin/llvm-gcc-4.2
# export CXX=/Developer/usr/bin/llvm-g++-4.2
# export OBJC=/Developer/usr/bin/llvm-gcc-4.2

TZ="America/New_York"
LC_ALL="en_US.UTF-8" # "en_US.ISO8859-1"
LC_NUMERIC=","
BLOCK_SIZE="'si" # Used by GNU Coreutils (gdf, gdu, gls)
LS_COLORS="exfxcxdxbxegedabagacad"
ZLS_COLORS="no=0:fi=0:di=32:ln=36:pi=31:so=33:bd=44;37:cd=44;37:ex=35:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36"
GREP_OPTIONS="--color=auto"
GREP_COLORS="ms=01:mc=34:sl=:cx=:fn=35:ln=32:bn=32:se=33"

if [[ -z $SSH_TTY ]]; then
	VISUAL="/usr/local/bin/mate -wr"
	# EDITOR="/usr/local/bin/mate -wr"
	LESSEDIT="%E ?lm--line lm. \"%f\""
else
	unset VISUAL 
	EDITOR="vi"
	LESSEDIT="%E ?lm--line lm. \"%f\""
fi

if [[ -n $XTERM_VERSION ]]; then
	if [[ $X11_PREFS_DOMAIN == "org.x.X11" ]]; then
		PATH=$PATH:/usr/X11/bin
		MANPATH=$MANPATH:/usr/X11/share/man
	elif [[ $X11_PREFS_DOMAIN == "org.macosforge.xquartz.X11" ]]; then
		PATH=$PATH:/opt/X11/bin
		MANPATH=$MANPATH:/opt/X11/share/man
	fi
	TERM="xterm-256color"
fi

if [[ -d /Applications/Server.app ]]; then
	path=( $path /Applications/Server.app/Contents/ServerRoot/usr/{bin,sbin,libexec} )
	MANPATH=$MANPATH:/Applications/Server.app/Contents/ServerRoot/usr/share/man
fi

if [[ -d /opt/local ]]; then
	path=( /opt/local/{bin,sbin,apache2/bin} $path )
	MANPATH=/opt/local/share/man:$MANPATH
	INFOPATH=/opt/local/share/info:$INFOPATH
fi

if [[ -d /usr/local/Library/Homebrew ]]; then
	# fpath=( /usr/local/share/zsh/functions $fpath )
	fpath=( /usr/local/share/zsh-completions $fpath )
	path=( $path /usr/local/opt/go/libexec/bin )
	INFOPATH=/usr/local/share/info:$INFOPATH
	HELPDIR=/usr/local/share/zsh/help
	export HOMEBREW_MAKE_JOBS=`sysctl -n machdep.cpu.core_count`
	export HOMEBREW_GITHUB_API_TOKEN=8dfec26db952ac2e10d42b591f0358d3cc72c2be
fi

if [[ -d /sw ]]; then
	PATH=/sw/bin:/sw/sbin:$PATH
	MANPATH=/sw/share/man:$MANPATH
	INFOPATH=/sw/share/info:$INFOPATH

	if [[ -x /sw/bin/init.sh ]]; then
		source /sw/bin/init.sh
	fi
fi

if [[ -d ~/.gsutil ]]; then
	PATH=${PATH}:$HOME/.gsutil
	PYTHONPATH=${PYTHONPATH}:$HOME/.gsutil/boto
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# GROWLNOTIFY=[[ true ]]

unsetopt ALL_EXPORT

typeset -U PATH INFOPATH MANPATH

# ========================
#      SHELL OPTIONS
# ========================
unsetopt MENU_COMPLETE
setopt EXTENDED_GLOB LIST_AMBIGUOUS NO_LIST_BEEP MULTIBYTE # GLOB_COMPLETE # COMPLETE_IN_WORD # COMBINING_CHARS
setopt COMBINING_CHARS 2>/dev/null
setopt FUNCTION_ARGZERO
setopt AUTO_PARAM_KEYS AUTO_PARAM_SLASH AUTO_REMOVE_SLASH AUTO_CD AUTO_LIST AUTO_MENU
setopt SHARE_HISTORY HIST_EXPIRE_DUPS_FIRST EXTENDED_HISTORY HIST_IGNORE_SPACE HIST_IGNORE_DUPS HIST_VERIFY HIST_NO_STORE HIST_FIND_NO_DUPS HIST_REDUCE_BLANKS

# ========================
#        FUNCTIONS
# ========================

unalias "run-help" 2>/dev/null

fpath=( $HOME/.zfunc $fpath )
# export FPATH
# autoload -U zrecompile
autoload $^fpath/*(N-.x:t)

# Customized 'ls'. (Colorized, long format, detailed time, not sorted [sorts more like the Finder], removed 'total' sum)
ll() {
	# d
	# for item in "$@"; do
	# 	d
	CLICOLOR_FORCE=1 ls -AFGPhlTWw $@ | grep -vE "(^total [0-9]+)|( (.\[[0-9]{2}m)?\.{1,2}(.\[m.\[m)?/$)"
	# CLICOLOR_FORCE=1 ls -AFfGPhlTWw $@ | grep -vE "(^total [0-9]+)|( (.\[[0-9]{2}m)?\.{1,2}(.\[m.\[m)?/$)"
}

# llS() — Customized 'ls'.  Like ll() (see above), but sorts by file size.
llS() { CLICOLOR_FORCE=1 ls -SAFGPhlTWw $@ | grep -vE "^total [0-9]+"; }

# lld() — Customized 'ls'.  Like ll() (see above), but directories are listed as plain files.
lld() { CLICOLOR_FORCE=1 ls -dAFGPhlTWw $@; }

# ll-G() — Customized 'ls'.  Like ll() (see above), but disables colorized output.
	# DOESN'T WORK --> # ll-G() { CLICOLOR_FORCE=0 CLICOLOR=0 ls -AcFfPhlTWw $@ | grep -vE "(^total [0-9]+)|( (.\[[0-9]{2}m)?\.{1,2}(.\[m.\[m)?/$)"; }
# Note: May only work by first executing "unset CLICOLOR; unset CLICOLOR_FORCE" in the shell.
ll-G() { ls -AFfPhlTWw $@ | grep -vE "(^total [0-9]+)|( (.\[[0-9]{2}m)?\.{1,2}(.\[m.\[m)?/$)"; }

# reloadfunc():
# For reloading a function after modifying it. (Note: only works on functions contained within your $fpath, e.g. not ones in here [.zshrc]).
### TODO: There's no need for the while loop -- 'unfunction' and 'autoload' can take multiple arguments.
reloadfunc() { while (( $# )); do unfunction "$1"; autoload -U "$1"; shift; done; }


# ========================
#        COMPLETION
# ========================

autoload -U compinit
compinit

zmodload zsh/complete 
zmodload zsh/complist 2>/dev/null	# Load the complist module in order for the 'menu-select' widget to work.

# :COMPLETION:<FUNCTION>:<COMPLETER>:<COMMAND>:<ARGUMENT>:<TAG>

# zstyle ':completion:hosts:*' use-ip true 

# Completion caching
zstyle ':completion::complete:*' use-cache true
zstyle ':completion::complete:*' cache-path ~/.zcompcache

# zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _menu _match _history custom-functions
# zstyle ':completion:*' completer _expand _list _complete _ignored _menu _match _history
## GOOD ONE: zstyle ':completion:*' completer _list _complete _expand _oldlist _menu _match _ignored _history
# zstyle ':completion:*' completer _list _oldlist _expand _complete _match _menu _ignored _history
# zstyle ':completion:*' completer _menu _expand _complete _match _list _oldlist _ignored _history
# # zstyle ':completion:*' completer _expand _match _complete _list _oldlist _menu _ignored _history
	# zstyle ':completion:*' completer _list _complete _expand _oldlist _menu _match _ignored _history
	# zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _prefix
	# zstyle ':completion:*' completer _list _complete _expand _oldlist _menu _match _ignored _history
	# zstyle ':completion:*' completer _list _complete _expand _menu _match _oldlist _ignored _history
	zstyle ':completion:*' completer _expand _complete _match _list _menu _oldlist _ignored # _history
	# zstyle ':completion:*' completer _expand _match _complete _menu _list _oldlist _ignored _history

# zstyle ':completion:*' completions true

zstyle ':completion:*' insert-unambiguous true												# true −› false (2009-03-20)    # (t → f)

zstyle ':completion:*' list true
zstyle ':completion:*' condition false
zstyle ':completion:*' list-grouped true
zstyle ':completion:*' expand prefix suffix
# zstyle ':completion:*' expand 'yes'

	## insert all expansions for expand completer
	# zstyle ':completion:*:expand:*' tag-order all-expansions

# zstyle ':completion:*:history:*' remove-all-dups true		# DISABLED (2011-06-15): Should already be set by setopt commands.
# zstyle ':completion:*:history:*' sort true				# DISABLED (2011-06-15): Is this really necessary?
zstyle ':completion:*' file-sort name
zstyle ':completion:*:descriptions' format $'%B%d%b'
zstyle ':completion:*:messages' format $'%B%{\e[35m%}-- %d --%{\e[39m%}%b'
zstyle ':completion:*:warnings' format $'%B%{\e[31m%}-- No Matches Detected --%{\e[39m%}%b'
zstyle ':completion:*' auto-description $'%B-- Specify: %d --%b'
zstyle ':completion:*' glob true
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd ..
    # zstyle ':completion:*' insert-unambiguous true												# true −› false (2009-03-20)    # (t → f)
zstyle ':completion:*' ambiguous true
# zstyle ':completion:*' accept-exact continue
# zstyle ':completion:*' menu yes=2 select=long-list remove-all-dups=true use-ip=true interactive search ###
# zstyle ':completion:*' menu yes=2 select=long-list remove-all-dups=true use-ip=true interactive ###
# zstyle ':completion:*' menu yes=2 select=long-list remove-all-dups=true use-ip=true interactive ###
# zstyle ':completion:*' menu auto select=long-list remove-all-dups=true use-ip=true interactive search ###
	# zstyle ':completion:*' menu automenu-unambiguous select=list interactive search
	zstyle ':completion:*' menu select=list

zstyle ':completion:*:default' list-colors ${(s.:.)ZLS_COLORS}
zstyle ':completion:*' list-suffixes true
# zstyle ':completion:*' match-original both
zstyle ':completion:*' matcher-list '+' '+r:|[._-]=** r:|=**'

# zstyle ':completion:*' menu yes=1 select=long-list use-ip=true interactive search ###

zstyle ':completion:*' select-prompt $'%SScrolling active: current selection at %l %p%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute true
zstyle ':completion:*' verbose true

# zstyle ':completion:reloadfunc:*:*:*:functions' $'$^HOME/.zfunc/*(N-.x:t)'
# zstyle ':completion:*:functions' custom-functions $^HOME/.zfunc/*(N-.x:t)
# zstyle ':completion:::reloadfunc:functions' custom-functions _functions
zstyle ':completion:*:*:-redirect-,2>,*:*:devices' $'/dev/null' 

# zstyle ':completion:*:ssh:*' hosts 10.0.34.{10,102,106,20} {mackie,energy,mackie2}{.snap.snappiness.com,}
# zstyle ':completion:*:ssh:*' users lawr max root
# zstyle ':completion:*:hosts' use-ip=yes
zstyle ':completion:*:hosts' use-ip true
zstyle ':completion:*:ssh:*' users-hosts {lawr,max}@{10.0.34.{10,102,106,20},{mackie,energy,mackie2}{.snap.snappiness.com,}}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# SOURCE: /opt/local/var/macports/software/zsh-devel/4.3.10_0+doc+examples+mp_completion+pcre/opt/local/share/doc/zsh-4.3.10/examples/caphuso/zshrc
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# zstyle ':completion:*' word true
zstyle ':completion:*:ping:*' hosts 10.0.34.{10,102,106,20} {mackie,energy,mackie2}{.snap.snappiness.com,}
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:kill:*' insert-ids single
zstyle ':completion:*:kill:*' verbose true
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
# zstyle ':completion:*' keep-prefix no
zstyle ':completion:*:man:*' separate-sections true
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# SOURCE: http://zshwiki.org/home/examples/compsys/
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Completing Something Appropriate:
# This will replace the default completion (files) with hosts, for the command sshx (which is a custom script)
	compdef _hosts portscan
	compdef _functions reloadfunc

# You want a completion function for pkill? write it :p or use one of the following, regarding the behavior you want:
	# compdef pkill=kill
	# compdef pkill=killall
	compdef ll=ls
	compdef locateH=slocate
	
# Subscript Completion:
# When completing inside array or association subscripts, the array elements are more useful than parameters so complete them first:
	zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters	

# Adding from Various SSH Files:
# Add the hostnames from all the files ssh uses for storing hosts and /etc/hosts based on /usr/share/doc/zsh/examples/ssh_completion2.gz. This will remove any entries that are negated and not give an error for files not present. Author not listed in ssh_completion2.gz.
	# local _myhosts;
	# _myhosts=( ${${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ }:#\!*}${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*} );
	# zstyle ':completion:*' hosts $_myhosts;

# Ignore Parent Directory:
# Useful for cd, mv and cp. Ex, cd will never select the parent directory (ie cd ../<TAB>):
	# zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd		# DISABLED (2011-06-15): Already taken care of earlier with the following command: zstyle ':completion:*' ignore-parents parent pwd ..

# Ignore What's Already in the Line:
# With commands like `rm/kill/diff' it's annoying if one gets offered the same filename again even if it is already on the command line.
	zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes

# Ignore Completion Functions:
	zstyle ':completion:*:functions' ignored-patterns '_*'

# Process Name Completion:
	# zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'
	zstyle ':completion:*:processes-names' command 'ps -ax -c -o command | sort --ignore-case --unique'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ========================
#         BINDINGS
# ========================

bindkey -r "^R"
bindkey -r "^Xr"
# bindkey -r "^["

bindkey "^[^[[D"	beginning-of-line 						# bindkey "\e\e\[D"	beginning-of-line
bindkey "^[[115"	beginning-of-line
bindkey "^[^[[C"	end-of-line
bindkey "^[[119"	end-of-line
# bindkey "\Eh"		run-help
bindkey "\Eh"		run-help
bindkey "\Ew"		which-command
bindkey "\Eq"		push-input

bindkey "^R"		history-incremental-pattern-search-backward				# Unavailable in Zsh v4.3.4 (Mac OS X 10.5.6), but works in Zsh v4.3.9.
bindkey "^Xr"		history-incremental-pattern-search-backward				# Unavailable in Zsh v4.3.4 (Mac OS X 10.5.6), but works in Zsh v4.3.9.
bindkey "^[[Z"		reverse-menu-complete
bindkey " "	  		magic-space		# Also do history expansion on space

# ========================
#         ALIASES
# ========================

alias allsizes='du -hs'
alias columns='column -ts " "'
alias fileinfo='file -krpb'
alias fileinfo2='/usr/bin/file -krpb'
alias llSpotlightFS="CLICOLOR_FORCE=1 ls -lfGhTwFL | tr ':' '/' | less -S"
alias mate='mate --recent '
alias past=' fc -linr'	# alias past=' fc -inr'	# alias past=' fc -lfinr 1'
# alias sudo='sudo '
alias L="less -S"
alias S="sort -f"
alias SL="sort -f | less -S"
alias lsof="lsof +c 0"
alias saveWebPage='wget -e robots=off --keep-session-cookies -pHE -P "saveWebPage (`date +%G-%m-%d\ %Hː%Mː%S`)"'
alias saveWebPageLocal='wget -e robots=off --keep-session-cookies -pHE --convert-links -P "saveWebPage (`date +%G-%m-%d\ %Hː%Mː%S`)"'
alias srm=" srm"
alias sudosrm=' sudo srm'
alias which-command='whence -a'

alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport "
alias lsregister="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"
alias lssave="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lssave"
alias resetLaunchServices="lsregister -kill -r -all system,local,user"
alias resetLaunchServices2="lsregister -kill -R -all system,local,user"
alias launchservices="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/LaunchServices"
alias launchservices_debug="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/LaunchServices_debug"
alias launchservices_profile="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/LaunchServices_profile"
alias SoftwareUpdateCheck="/System/Library/CoreServices/Software Update.app/Contents/Resources/SoftwareUpdateCheck"
alias portscan="/System/Library/CoreServices/Applications/Network\ Utility.app/Contents/Resources/stroke"
alias pmTool="/Applications/Utilities/Activity\ Monitor.app/Contents/Resources/pmTool"
alias -g kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
alias pcx2="/Developer/Applications/Utilities/pcxapp2.app/Contents/Resources/pcx2"
alias requiem="/usr/local/bin/requiem-1.0/decrypt"
alias applicationCreator="/Repository/SourceCode/JavaScript/gwt-mac/applicationCreator"
alias man-camcapture="open /usr/local/bin/camcapture.rtf"

# ========================
#     COLORIZE STDERR
# ========================

# Source: http://en.gentoo-wiki.com/wiki/Zsh#Colorize_STDERR

exec 2>>(while read -r -k -u 0 char; do
  print -f "%b%c%b" "\e[91m" "${char}" "\e[39m" > /dev/tty; done &)

# Because of the above exec line, trying to log in as root with 'su' immediately gets suspended.  To get around this, we use "sudo screen $SHELL".
alias sudoScreenZsh="sudo screen $SHELL"

# ========================
#    GROWL NOTIFICATION
# ========================
	
	### DISABLED (2011-06-06) in order to speed up the shell

	# preexec() {
	# # Pre command execution
	# 
	# 	# Define timer and cmd for Growl notification
	# 	PREEXEC_TIME=$(date +'%s')
	# 	CMD_FULL="$3"
	# 	CMD_SHORT=( $(print -r "${1:gs/;/ /}") )	# set -A CMD_SHORT $(echo "${(q)2}")
	# 
	# 	# debug "\$1:\n“${(q)1}”\n" "\$2:\n“${(q)2}”\n" "\$3:\n“${(q)3}”"
	# }

	# precmd() {
	# # Post command execution
	# 
	# 	if [[ -n ${CMD_FULL} ]]; then
	# 		# Exit if we ran one of several select commands
	# 		GROWL_IGNORE=(man less more tail pico nano vi emacs man run-help ssh lynx links ps pss)	# GROWL_IGNORE="( 'man' 'less' 'more' 'tail' 'pico' 'nano' 'vi' 'emacs' 'man' 'ssh' 'ps' )"
	# 		echo "${CMD_FULL}" | grep -Ew "${(pj:|:)GROWL_IGNORE}" &>/dev/null && unset PREEXEC_TIME CMD_FULL CMD_SHORT GROWL_IGNORE && return # echo "${CMD_FULL}" | grep -Ew "(man|less|more|tail|pico|nano|vi|emacs|man|ssh|ps)" &>/dev/null && return 0
	# 		unset GROWL_IGNORE
	# 	else
	# 		# Exit if command is empty
	# 		return
	# 	fi
	# 
	# 	local DELAY_AFTER_NOTIFICATION=10			# Time (in seconds) after which to trigger a growl notification	
	# 	local start=${PREEXEC_TIME:-`date +'%s'`}	# Get the start time or set it to now if not set
	# 	local stop=$(date +'%s')
	# 	local elapsed=$(($stop-$start))
	# 
	# 	# Exit if not enough time has elapsed for us to display the notification
	# 	if [[ $elapsed -lt $DELAY_AFTER_NOTIFICATION || -z ${CMD_SHORT} ]]; then
	# 		unset PREEXEC_TIME CMD_FULL CMD_SHORT
	# 		return
	# 	fi
	# 
	# 	# Break elapsed time down into days, hours, minutes, and seconds		
	# 	(( seconds = $elapsed % 60 ))             # (( days = $elapsed / (60 * 60 * 24) ))
	# 	(( minutes = $elapsed / 60 % 60 ))        # (( hours = $elapsed / (60 * 60) - ($days * 24) ))
	# 	(( hours = $elapsed / (60 * 60) % 24 ))   # (( minutes = $elapsed / 60 - ($days * 24 * 60) - ($hours * 60) ))
	# 	(( days = $elapsed / (60 * 60 * 24) ))    # (( seconds = $elapsed - ($days * 24 * 60 * 60) - ($hours * 60 * 60) - ($minutes * 60) ))
	# 
	# 	# another method:
	# 	#
	# 	# days = time / 86400
	# 	# time = time % 86400 						// 60*60*24
	# 	# hour = time / 3600							// 60*60
	# 	# minute = (time % 3600) / 60
	# 	# second = time - hour * 3600 - minute * 60
	# 
	# 	# Create the duration strings
	# 	if [[ $days -gt 0 ]]; then duration="${days}d ${hours}h ${minutes}m ${seconds}s"	# Duration: 3d 2h 28m 46s
	# 	elif [[ $hours -gt 0 ]]; then duration="${hours}h ${minutes}m ${seconds}s"			# Duration: 2h 28m 46s
	# 	elif [[ $minutes -gt 0 ]]; then duration="${minutes}m ${seconds}s"					# Duration: 28m 46s
	# 	else duration="${seconds}s"															# Duration: 46s
	# 	fi
	# 
	# 	# Determine Notification's Priority
	# 	local PRI
	# 	if [[ $elapsed -ge 3600 ]]; then PRI="2"
	# 	elif [[ $elapsed -ge 300 ]]; then PRI="1"
	# 	elif [[ $elapsed -ge 60 ]]; then PRI="0"
	# 	elif [[ $elapsed -ge 10 ]]; then PRI="-1"
	# 	else PRI="-2"
	# 	fi
	# 		
	# 	# Create the abbreviated command portion of the notification title
	# 	local -a CMD_TITLE
	# 	for ((i=1; i <= ${#CMD_SHORT}; ++i)); do
	# 		WORD=$CMD_SHORT[$i]	# WORD=$(echo "$CMD_SHORT" | awk -v i=$i '{ print $i }')
	# 		if [[ -n $(whence -- "${WORD}") || "${WORD}" == '|' ]]; then
	# 			CMD_TITLE+=( ${WORD} )	# CMD_TITLE=$CMD_TITLE[1,-2]
	# 		fi
	# 	done
	# 
	# 	# Check that we don't display the command twice unnecessarily
	# 	[[ $CMD_FULL == $CMD_TITLE ]] && CMD_FULL=""
	# 
	# 	# Determine Terminal Application Being Used
	# 	local APP
	# 	if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then APP="Terminal.app"
	# 	elif [[ $TERM_PROGRAM == "iTerm.app" ]]; then APP="iTerm.app"
	# 	elif [[ -n $XTERM_VERSION ]]; then APP="X11.app"
	# 	else APP="growlnotify"
	# 	fi
	# 
	# 	# Check if we're SSH'ing and finally display the Growl notification
	# 	if [[ -z $SSH_CLIENT ]]; then
	# 		echo "${CMD_FULL}" | growlnotify -p $PRI -a $APP -d "com.squidinc.zshGrowl" "“$CMD_TITLE” ($duration)"
	# 	else
	# 		echo "${CMD_FULL}" | growlnotify -ucH $(echo $SSH_CLIENT | awk '{print $1}') -p $PRI -a $APP -d "com.squidinc.zshGrowl" "“$CMD_TITLE” ($duration)"
	# 	fi
	# 
	# 	# Reset execution parameters since the command has ended
	# 	unset PREEXEC_TIME CMD_FULL CMD_SHORT
	# 
	# }

	# # Check if growlnotify exists or if $GROWLNOTIFY is off.
	# # [[ /usr/bin/which -s "growlnotify"
	# 
	# # local growlnotifyExists="[[ -n `whence growlnotify` ]]"
	# if ! (whence growlnotify &>/dev/null && $GROWLNOTIFY); then
	# 	unfunction preexec precmd
	# fi
	# 
	# # DEBUG TEMP (2011-04-05)
	# # unfunction preexec precmd

# ========================
#   SSHFS MOUNT ALIASES
# ========================

	# local ICONPATH="/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources"
	# local ICONPATH_ALT="/Volumes/Sentience/Repository/Images/Icons"
	# local IPHONEICON="/System/Library/Image\ Capture/Support/Icons/Apple\ iPhone.icns"
	# 
	# alias mountMackieSSH=" mkdir -p /Volumes/MackieSSH && sshfs 10.0.34.10:/ /Volumes/MackieSSH -oreconnect,noappledouble,nolocalcaches,rdonly,idmap=user,kill_on_unmount,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH || rmdir /Volumes/MackieSSH"
	# alias mountMackieSSH-max-nocache-r=" mkdir -p /Volumes/MackieSSH-max-nocache-r && sshfs 10.0.34.10:/ /Volumes/MackieSSH-max-nocache-r -oreconnect,noappledouble,nolocalcaches,rdonly,idmap=user,kill_on_unmount,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH || rmdir /Volumes/MackieSSH-max-nocache-r"
	# alias mountMackieSSH-max-nocache-rw-1022=" mkdir -p /Volumes/MackieSSH-max-nocache-rw-1022 && sshfs 10.0.34.10:/ /Volumes/MackieSSH-max-nocache-rw-1022 -oreconnect,noappledouble,nolocalcaches,idmap=user,kill_on_unmount,port=1022,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH-max-nocache-rw-1022 || rmdir /Volumes/MackieSSH-max-nocache-rw-1022"
	# alias mountMackieSSH-max-nocache-rw=" mkdir -p /Volumes/MackieSSH-max-nocache-rw && sshfs 10.0.34.10:/ /Volumes/MackieSSH-max-nocache-rw -oreconnect,noappledouble,nolocalcaches,idmap=user,kill_on_unmount,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH-max-nocache-rw || rmdir /Volumes/MackieSSH-max-nocache-rw"
	# 
	## alias mountMackieSSH-lawr-nocache-r=" mkdir -p /Volumes/MackieSSH-lawr-nocache-r && sshfs lawr@10.0.34.10:/ /Volumes/MackieSSH-lawr-nocache-r -oreconnect,noappledouble,nolocalcaches,rdonly,idmap=user,kill_on_unmount,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH-lawr-nocache-r || rmdir /Volumes/MackieSSH-lawr-nocache-r"
	# alias mountMackieSSH-lawr-nocache-r-a=" mkdir -p /Volumes/MackieSSH-lawr-nocache-r-a && sshfs lawr@10.0.34.10:/Users/lawr/Library/Application\ Support/Adium\ 2.0/Users/Default/Logs/AIM.sexydognyc /Volumes/MackieSSH-lawr-nocache-r-a -oreconnect,noappledouble,nolocalcaches,rdonly,idmap=user,kill_on_unmount,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH-lawr-nocache-r-a || rmdir /Volumes/MackieSSH-lawr-nocache-r-a"
	# alias mountMackieSSH-lawr-nocache-rw=" mkdir -p /Volumes/MackieSSH-lawr-nocache-rw && sshfs lawr@10.0.34.10:/ /Volumes/MackieSSH-lawr-nocache-rw -oreconnect,noappledouble,nolocalcaches,idmap=user,kill_on_unmount,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH-lawr-nocache-rw || rmdir /Volumes/MackieSSH-lawr-nocache-rw"
	# alias mountMackieSSH-lawr-nocache-rw-1022=" mkdir -p /Volumes/MackieSSH-lawr-nocache-rw-1022 && sshfs lawr@10.0.34.10:/ /Volumes/MackieSSH-lawr-nocache-rw-1022 -oreconnect,noappledouble,nolocalcaches,idmap=user,kill_on_unmount,port=1022,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH-lawr-nocache-rw-1022 || rmdir /Volumes/MackieSSH-lawr-nocache-rw-1022"
	# alias mountMackieSSH-lawr-cache-r=" mkdir -p /Volumes/MackieSSH-lawr-cache-r && sshfs lawr@10.0.34.10:/ /Volumes/MackieSSH-lawr-cache-r -oreconnect,noappledouble,rdonly,idmap=user,kill_on_unmount,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH-lawr-cache-r || rmdir /Volumes/MackieSSH-lawr-cache-r"
	# 
	# alias mountMackieSSH-root-cache-r=" mkdir -p /Volumes/MackieSSH-root-cache-r && sshfs root@10.0.34.10:/ /Volumes/MackieSSH-root-cache-r -oreconnect,noappledouble,rdonly,kill_on_unmount,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH-root-cache-r || rmdir /Volumes/MackieSSH-root-cache-r"
	# alias mountMackieSSH-root-nocache-r=" mkdir -p /Volumes/MackieSSH-root-nocache-r && sshfs root@10.0.34.10:/ /Volumes/MackieSSH-root-nocache-r -oreconnect,noappledouble,nolocalcaches,rdonly,kill_on_unmount,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH-root-nocache-r || rmdir /Volumes/MackieSSH-root-nocache-r"
	# alias mountMackieSSH-root-nocache-rw=" mkdir -p /Volumes/MackieSSH-root-nocache-rw && sshfs root@10.0.34.10:/ /Volumes/MackieSSH-root-nocache-rw -oreconnect,noappledouble,nolocalcaches,kill_on_unmount,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH-root-nocache-rw || rmdir /Volumes/MackieSSH-root-nocache-rw"
	# alias mountMackieSSH-root-nocache-r-1022=" mkdir -p /Volumes/MackieSSH-root-nocache-r-1022 && sshfs root@10.0.34.10:/ /Volumes/MackieSSH-root-nocache-r-1022 -oreconnect,noappledouble,nolocalcaches,rdonly,port=1022,kill_on_unmount,volicon=$ICONPATH/com.apple.macpro.icns,volname=MackieSSH-root-nocache-r-1022 || rmdir /Volumes/MackieSSH-root-nocache-r-1022"
	# 
	# alias mountMorganSSH-max-nocache-r=" mkdir -p /Volumes/MorganSSH-max-nocache-r && sshfs mkg.dnsalias.com:/ /Volumes/MorganSSH-max-nocache-r -oreconnect,noappledouble,nolocalcaches,rdonly,idmap=user,kill_on_unmount,volname=MorganSSH-max-nocache-r || rmdir /Volumes/MorganSSH-max-nocache-r"
	# alias mountMorganSSH-max-nocache-rw=" mkdir -p /Volumes/MorganSSH-max-nocache-rw && sshfs mkg.dnsalias.com:/ /Volumes/MorganSSH-max-nocache-rw -oreconnect,noappledouble,nolocalcaches,idmap=user,kill_on_unmount,volname=MorganSSH-max-nocache-rw || rmdir /Volumes/MorganSSH-max-nocache-rw"
	# 
	# alias mountRouterSSH=" mkdir -p /Volumes/RouterSSH && sshfs root@10.0.34.7:/ /Volumes/RouterSSH -oreconnect,noappledouble,nolocalcaches,kill_on_unmount,volname=RouterSSH || rmdir /Volumes/RouterSSH"
	# alias mountiPhoneSSH-nocache-r=" mkdir -p /Volumes/iPhoneSSH-nocache-r && sshfs root@10.0.34.22:/ /Volumes/iPhoneSSH-nocache-r -oreconnect,noappledouble,nolocalcaches,rdonly,idmap=user,kill_on_unmount,volicon=$IPHONEICON,volname=iPhoneSSH || rmdir /Volumes/iPhoneSSH-nocache-r"
	# alias mountiPhoneSSH-nocache-rw=" mkdir -p /Volumes/iPhoneSSH-nocache-rw && sshfs root@10.0.34.22:/ /Volumes/iPhoneSSH-nocache-rw -oreconnect,noappledouble,nolocalcaches,idmap=user,kill_on_unmount,volicon=$IPHONEICON,volname=iPhoneSSH || rmdir /Volumes/iPhoneSSH-nocache-rw"

# -------------------------------------------------------------------------------------
# TODO: verify that /usr/bin/man is chown'd man:wheel && chmod'd 4555 (how about 4755?)
# -------------------------------------------------------------------------------------
# something to do with termcap/terminfo.  source: http://aplawrence.com/Unixart/termcap.html
# eval `tset -m wyse60:wy60 -m vt100:vt100 -m ansi:${TERM:-ansi} -m :\?${TERM:-ansi} -e -r -s -Q`

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
