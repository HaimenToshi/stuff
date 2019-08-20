# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
alias sudo='sudo '
alias emerge='emerge'
alias ls='ls -lhsa --color=auto' 
alias dmesg='dmesg --ctime'
alias df='df -h'
alias youtube-flac='youtube-dl --quiet --ignore-errors --extract-audio --audio-format flac --output "%(title)s.%(ext)s"'
alias youtube-dl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --output '%(title)s.%(ext)s'"
#alias nano='nano --softwrap'
alias cp='cp -ap'
# no double entries in the shell history && Enable commands completion support
export HISTCONTROL="$HISTCONTROL erasedups:ignoreboth"


#Fix Libreoffice UI
export SAL_USE_VCLPLUGIN=gtk3


# Display a nice system properties using Screenfetch
#neofetch --backend off --color_blocks off --disable theme icons wm_theme wm de resolution term

#Nice bash prompt

#PS1="[ \[$(tput sgr0)\]\[\033[38;5;39m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;10m\]@\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;196m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;51m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] ] \[$(tput sgr0)\]"
PS1="\[\033[38;5;14m\][\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;51m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;14m\]]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
