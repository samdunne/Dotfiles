# completion
autoload -U compinit
compinit

# makes color constants available
autoload -U colors
colors

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,zsh_prompt,exports,aliases,functions,paths}; do
	[ -r "$file" ] && source "$file"
done
unset file

# proxy settings
location=`/usr/sbin/networksetup -getcurrentlocation`

if [ "$location" == "work" ]
then
  export http_proxy=http://localhost:3128
  export https_proxy=$http_proxy
  export no_proxy="10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,127.0.0.0/8,localhost"
fi

if [ "$location" == "home" ]
then
  unset http_proxy
  unset https_proxy
fi

# prompt
export rvm_max_time_flag=200
eval "$(chef shell-init zsh)"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh
