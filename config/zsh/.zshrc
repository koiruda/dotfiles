# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# path
ZSH_DOT_DIR="${XDG_CONFIG_HOME}/zsh"

# History
export HISTFILE="${XDG_STATE_HOME}/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
DIRSTACKSIZE=100

setopt AUTO_CD
setopt AUTO_PUSHD
setopt GLOBDOTS
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt SHARE_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_NO_STORE
setopt HIST_EXPAND
setopt INC_APPEND_HISTORY

# Load powerlevel10k theme
zinit ice depth=1; zinit light romkatv/powerlevel10k
source "${ZSH_DOT_DIR}/.p10k.zsh"

# Async load plugins
zinit wait lucid null for \
    atinit'source "${ZSH_DOT_DIR}/.zshrc.lazy"' \
    @'zdharma-continuum/null'
