# ── Zinit ──────────────────────────────────────────────────────
export ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
    print -P "%F{33}Installing Zinit…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# ── Oh-My-Zsh ──────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  docker docker-compose
  kubectl helm terraform
  aws gcloud azure ansible
  python pip node npm yarn golang rust
  sudo extract history
  command-not-found archlinux
  copypath dirhistory
  fzf-tab
)

source $ZSH/oh-my-zsh.sh

# ── Completion ─────────────────────────────────────────────────
autoload -Uz compinit
compinit -C

# Show completion menu below prompt (requirement 3)
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
# fzf-tab: use fzf dropdown for tab completion
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --color=always $realpath 2>/dev/null'
zstyle ':fzf-tab:*' switch-group ',' '.'

# ── Zinit plugins (eager, no wait) ─────────────────────────────
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Autosuggestion config
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# ── History ────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt HIST_FIND_NO_DUPS

# ── Keybindings ────────────────────────────────────────────────
bindkey "^[[A" up-line-or-history      # up arrow
bindkey "^[[B" down-line-or-history    # down arrow
bindkey "^U" kill-whole-line           # ctrl+u clears prompt
bindkey "^[[Z" reverse-menu-complete   # shift+tab reverse complete

# ── NVM ────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use
nvm use default --silent

# ── Paths ──────────────────────────────────────────────────────
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH:$HOME/.local/bin"
export PATH=$PATH:$HOME/.cargo/bin
export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export PATH="$PATH:$HOME/.dotnet/tools"

# .NET OPTIONAL ENV
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export ASPNETCORE_ENVIRONMENT=Development

# ── Editors ────────────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man!"

# ── Tmuxifier ──────────────────────────────────────────────────
eval "$(tmuxifier init -)"

# ── Zoxide ──────────────────────────────────────────────────
eval "$(zoxide init zsh)"

# ── fzf ────────────────────────────────────────────────────────
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a"

# ── eza colors ─────────────────────────────────────────────────
export EZA_COLORS="di=34:ln=36:ex=32:fi=0:ur=0:uw=0:ux=0:ue=0:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:su=0:sf=0:xa=0:da=0:sn=0:sb=0:uu=0:un=0:gu=0:gn=0"

# ── Aliases ────────────────────────────────────────────────────
# powered by zoxide
alias cd="z"
alias cdi="zi"          
alias ..="z .."
alias ...="z ../.."
alias ....="z ../../.."

alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first --git"
alias lt="eza --tree --icons --level=2"
alias cat="bat"
alias grep="rg"
alias find="fd"

alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gpl="git pull"
alias glog="git log --oneline --graph --decorate"

alias v="nvim"
alias vi="nvim"
alias vim="nvim"

alias hyprconfig="nvim ~/.config/hypr/hyprland.conf"

alias update="sudo pacman -Syu"
alias install="sudo pacman -S"
alias search="pacman -Ss"
alias remove="sudo pacman -Rns"
alias cleanup="sudo pacman -Sc"

alias d="docker"
alias dc="docker compose"
alias dps="docker ps"
alias dpsa="docker ps -a"

alias reload="source ~/.zshrc"
alias zshconfig="nvim ~/.zshrc"
alias path='echo -e ${PATH//:/\\n}'

# ── Starship ───────────────────────────────────────────────────
export STARSHIP_LOG=error
eval "$(starship init zsh)"
