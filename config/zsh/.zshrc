# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

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
source "${XDG_CONFIG_HOME}/zsh/.p10k.zsh"

function git_status() {
    echo git status
    git status -sb
    zle reset-prompt
}
zle -N git_status

bindkey '^r' zaw-history
bindkey '^g' zaw-git-branches
bindkey '^v' git_status

zinit light-mode for \
    zsh-users/zsh-autosuggestions \
    zdharma/fast-syntax-highlighting \
    zdharma/history-search-multi-word \
    b4b4r07/enhancd \
    zsh-users/zsh-completions \
    zsh-users/zaw

zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras

zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS


### End of Zinit's installer chunk

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

alias vi='nvim'

alias t='tig'
alias ta='tig --all'

alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gp='git pull'
alias gpu='git push'
alias gs='git status'
alias gsw='git switch'
alias gre='git restore'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias grs='git rebase --skip'
alias gr1='git rebase -i HEAD~'
alias gr2='git rebase -i HEAD~~'
alias gr3='git rebase -i HEAD~~~'
alias gr4='git rebase -i HEAD~~~~'
alias gr5='git rebase -i HEAD~~~~~'

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
