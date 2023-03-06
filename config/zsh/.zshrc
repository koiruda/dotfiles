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
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_NO_STORE
setopt HIST_EXPAND
setopt INC_APPEND_HISTORY
setopt NOAUTOREMOVESLASH
setopt MAGIC_EQUAL_SUBST
setopt HIST_VERIFY

# Run ls command when directory changed
chpwd() {
    file_count=`ls -1U | wc -l`
    line_count=`COLUMNS=${COLUMNS} ls -C | wc -l`
    if [ ${line_count} -lt 10 ]; then
        ls -F --color=auto
        return 0
    fi
    COLUMNS=${COLUMNS} ls -C | head -n 5
    echo "...more files. Total: ${file_count} files"
}

# Load powerlevel10k theme
zinit ice depth=1; zinit light romkatv/powerlevel10k
source "${ZSH_DOT_DIR}/.p10k.zsh"

# Async load plugins
zinit wait lucid null for \
    atinit'source "${ZSH_DOT_DIR}/.zshrc.lazy"' \
    @'zdharma-continuum/null'

# Wsl only
if [[ "$(uname -r)" == *microsoft* ]] && [ type docker &> /dev/null ]; then
    service docker status > /dev/null 2>&1
    if [ $? != 0 ]; then
        sudo service docker start
    fi
fi
