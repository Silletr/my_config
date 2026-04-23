#!/bin/zsh

# Starship (must be at the top because it adjusts prompt)
eval "$(starship init zsh)"

# === PATH ===
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
export DISPLAY=:0
unset WAYLAND_DISPLAY

# === ENV ===
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk/
export PYTHONPATH="$HOME/.pythonrc:$PYTHONPATH"

#    ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#    ┃    Oh My Zsh (keep plugins, remove P10K theme)    ┃
#    ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Starship takes over

#  ━━━━━ Plugins (all available in Arch via OMZ or AUR) ━━━━━

plugins=(
  git z zsh-autosuggestions zsh-syntax-highlighting
  gitfast
  docker
  python
  rust
  poetry
  npm
  command-not-found
  sudo
  colored-man-pages
  direnv
  fzf
)

source $ZSH/oh-my-zsh.sh

#    ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#    ┃     Completions + fzf      ┃
#    ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 'di=36'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# FZF key bindings (if installed via pacman or AUR)
test -f /usr/share/fzf/completion.zsh && source /usr/share/fzf/completion.zsh
test -f /usr/share/fzf/key-bindings.zsh && source /usr/share/fzf/key-bindings.zsh

# === Aliases (dev) ===
alias gst='git status'
alias gcm='git commit -m'
alias gd='git diff'
alias gpl='git pull'               # Fixed typo: `git update` → `git pull`
alias gms='git merge --squash'
alias gbc='git switch'

alias c='clear'
alias format_ruff='ruff check . --fix'
alias e='exit'
alias reload='source ~/.zshrc; echo "🔄 zsh reloaded!"'
alias move='mv'
alias remove='rm -i'
alias rm_fold='rm -rf'
alias lazy_git='/lazygit'

alias jq='jq .'
alias st='streamlit run main.py'
alias calc='cd streamlit_apps/Exchange_Calculator'
alias lazydevhelp='cd ~/Projects/LazyDeveloperHelper && source ~/Projects/ProjectsEnv/bin/activate && git switch dev'

alias rython='python3 ~/Projects/Rython/rython/test.py'
alias rython_dir="cd ~/Projects/Rython/ && source ~/Projects/ProjectsEnv/bin/activate"
alias build_rython="cd ~/Projects/Rython/ && source ~/Projects/ProjectsEnv/bin/activate && cd rython/jit/__rust__/ && cargo build --release && maturin develop --release"
alias move_rython_so='cd "$HOME/Projects/Rython/rython/jit/__rust__/target/release" && mv -f librython_jit.so rython_jit.so && mv -f rython_jit.so ../../../../../'

alias telegram_bot='cd ~/Projects/bots/ && source ~/Projects/ProjectsEnv/bin/activate'

alias pls='git pull'                         # Shorter pull
alias lg='lazygit'                        # Faster typing
alias python='python3'
alias pip='python3 -m pip'
alias tree='lsd --tree'
alias venv='source ~/Projects/ProjectsEnv/bin/activate'
alias db='direnv allow'
alias pj='cd ~/Projects'
alias pg='cd ~/Projects && lsd | fzf | xargs cd'
alias ahk='~/.local/bin/ahk_x11.AppImage'

#  ───── Autojump (if installed via pacman or AUR) ─────

[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

#  ───────── ZSH completion ─────────
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit
compinit -u

#  ━━━━━━━━━ Starship must be at the end of the file ━━━━━━━━━
eval "$(starship init zsh)"

#    ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#    ┃              cord.nvim Discord bridge               ┃
#    ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
unalias nvim 2>/dev/null || true
nvim() {
  if ! pgrep -f "socat UNIX-LISTEN:/tmp/discord-ipc-0" > /dev/null 2>&1; then
    [ -e /tmp/discord-ipc-0 ] && rm -f /tmp/discord-ipc-0
    socat UNIX-LISTEN:/tmp/discord-ipc-0,fork,reuseaddr \
      EXEC:"/mnt/d/npiperelay/npiperelay.exe -ei -s //./pipe/discord-ipc-0",nofork 2>/dev/null &
  fi
  command nvim "$@"
}

# === SDKMAN ===
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
