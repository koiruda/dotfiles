# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTFILE=~/.zsh_history

setopt share_history
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
setopt inc_append_history

function chpwd() { ls }

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit ice depth=1; zplugin light romkatv/powerlevel10k

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

function git_status() {
    echo git status
    git status -sb
    zle reset-prompt
}
zle -N git_status

bindkey '^r' zaw-history
bindkey '^g' zaw-git-branches
bindkey '^v' git_status

autoload -Uz compinit
compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
