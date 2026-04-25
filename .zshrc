#!/bin/zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/starship-prompt-${(%):-%n}.toml" ]]; then
  eval "$(starship init zsh --print-full-init | sed -n '1p')"
fi

export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
export PATH="$PATH:/home/silletr/.spicetify:/snap/bin:/usr/bin"
export DISPLAY=:0
export WAYLAND_DISPLAY=wayland-0

# WSLg Wayland runtime setup
if [ -z "$XDG_RUNTIME_DIR" ]; then
  export XDG_RUNTIME_DIR=/run/user/$UID
  if [ ! -d "$XDG_RUNTIME_DIR" ]; then
    sudo mkdir -p "$XDG_RUNTIME_DIR" && sudo chown $UID:$UID "$XDG_RUNTIME_DIR"
  fi
  # Symlink WSLg sockets
  [ ! -L "$XDG_RUNTIME_DIR/wayland-0" ] && ln -s /mnt/wslg/runtime-dir/wayland-0 "$XDG_RUNTIME_DIR/"
  [ ! -L "$XDG_RUNTIME_DIR/wayland-0.lock" ] && ln -s /mnt/wslg/runtime-dir/wayland-0.lock "$XDG_RUNTIME_DIR/"
fi

# === ENV ===
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PYTHONPATH="$HOME/.pythonrc:$PYTHONPATH"

# === Oh My Zsh (keep plugins, remove P10K theme) ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Starship takes over

# === ENHANCED Plugins (originals + dev/gamer power) ===
plugins=(
  git z zsh-autosuggestions zsh-syntax-highlighting
  # NEW: Dev productivity (you'll love these)
  gitfast      # 10x faster git status
  docker       # Docker completions  
  python       # Python arg completions
  rust         # Cargo completions
  poetry       # Poetry completions (my movie project)
  npm          # Node/Bun completions
  
  # NEW: Gaming/CLI power
  command-not-found
  sudo
  colored-man-pages
  autojump     # `j project` → jumps to ~/Projects/project
  
  # NEW: Modern dev tools
  direnv       # .envrc auto-loading
  fzf          # Fuzzy finder integration
)

source $ZSH/oh-my-zsh.sh
[[ -s /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh

# === Completion (your styles + fzf) ===
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 'di=36'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
source /usr/share/doc/fzf/examples/key-bindings.zsh 2>/dev/null || true


alias gst='git status'
alias gcm='git commit -m'
alias gd='git diff'
alias gpl='git update'
alias gms="git merge --squash"
alias gbc='git switch'

alias c='clear'
alias format_ruff='ruff check . --fix'
alias e='exit'
alias reload='source ~/.zshrc; echo "🔄 zsh reloaded!"'
alias move='mv'
alias remove='rm -i'
alias rm_fold='rm -rf -d'
alias lazy_git='/snap/bin/lazygit'

alias jq='jq .'
alias st='streamlit run main.py'
alias calc='cd streamlit_apps/Exchange_Calculator'

alias rython='python3 ~/Projects/Rython/rython/test.py'
alias rython_dir="cd ~/Projects/Rython/ && source ~/Projects/ProjectsEnv/bin/activate"
alias build_rython="cd ~/Projects/Rython/ && source ~/Projects/ProjectsEnv/bin/activate && cd rython/jit/__rust__/ && cargo build --release && maturin develop --release"
alias move_rython_so='cd "$HOME/Projects/Rython/rython/jit/__rust__/target/release" && mv -f librython_jit.so rython_jit.so && mv -f rython_jit.so ../../../../../'

alias telegram_bot='cd ~/Projects/bots/ && source ~/Projects/ProjectsEnv/bin/activate'

# === NEW Aliases (dev/gamer you'll use daily) ===
alias pls='git pl'                          # Shorter pull
alias gco='git checkout'                    # Branch switch
alias lg='lazygit'                          # Faster typing
alias python='python3'                      # WSL fix
alias pip='python3 -m pip'
alias tree='lsd --tree'
alias venv='source ~/Projects/ProjectsEnv/bin/activate'
alias db='direnv allow'                     # Direnv hook
alias pj='cd ~/Projects'                    # Projects jump
alias pg='cd ~/Projects && lsd | fzf | xargs cd'  # Fuzzy project jump
alias ahk='~/.local/bin/ahk_x11.AppImage'


# === Starship (cross-shell, Rust-fast, auto-config) ===
eval "$(starship init zsh)"

# === cord.nvim Discord Bridge ===
unalias nvim 2>/dev/null || true   # Just in case
nvim() {
    if ! pgrep -f "socat UNIX-LISTEN:/tmp/discord-ipc-0" > /dev/null 2>&1; then
        [ -e /tmp/discord-ipc-0 ] && rm -f /tmp/discord-ipc-0

        socat UNIX-LISTEN:/tmp/discord-ipc-0,fork,reuseaddr \
            EXEC:"/mnt/c/Users/Silletr/npiperelay/npiperelay.exe -ei -s //./pipe/discord-ipc-0",nofork 2>/dev/null &
    fi
    command nvim "$@"
}

# === FZF (fuzzy finder - install: sudo apt install fzf) ===
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# === ZSH extras (fix compdump errors) ===
# Added by deepsource CLI (shell completions)
fpath=(~/.zsh/completions $fpath)

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
eval "$(but completions zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
