export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export HIST_STAMPS="yyyy-mm-dd"

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt BANG_HIST
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS # Do not display a previously found event.
setopt HIST_IGNORE_SPACE # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.
setopt HIST_VERIFY       # Do not execute immediately upon history expansion.
setopt INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt HIST_REDUCE_BLANKS
setopt IGNORE_EOF
setopt AUTO_PUSHD        # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
setopt PUSHD_SILENT      # Do not print the directory stack after pushd or popd.
setopt AUTO_LIST
setopt AUTO_REMOVE_SLASH
setopt LIST_AMBIGUOUS
setopt EXTENDED_GLOB
setopt NO_BEEP
setopt CASE_MATCH
setopt CASE_PATHS
setopt CSH_NULL_GLOB
setopt COMPLETE_IN_WORD
setopt PROMPT_SUBST
setopt NO_HUP
setopt NO_LIST_BEEP

bindkey -e
autoload -z edit-command-line
zle -N edit-command-line

bindkey "^X^E" edit-command-line
bindkey "^O" autosuggest-accept
bindkey "^B" backward-word
bindkey "^F" forward-word
bindkey "^H" backward-char
bindkey "^L" end-of-line
bindkey "^D" delete-char
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^Y" accept-search
bindkey "^W" backward-kill-word
bindkey "^K" interrupt

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Load zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.zsh}
source $ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CUSTOM/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH="$HOME/.local/bin:$PATH"
