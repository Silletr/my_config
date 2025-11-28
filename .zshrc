# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# === PATH ===
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/usr/bin"
export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/home/silletr/.spicetify"
export PATH="$PATH:/snap/bin"

# === ENV ===
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PYTHONPATH="$HOME/.pythonrc:$PYTHONPATH"

# === Oh My Zsh ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
# === Completion ===
plugins=(
  git
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 'di=36'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
source $ZSH/oh-my-zsh.sh

# === Aliases ===
alias gst='git status'
alias gcm='git commit -m'
alias gac='git add .; git commit'
alias gp='git push origin'
alias gpl='git pull origin'
alias gbc='git switch'

alias c='clear'
alias format_ruff='ruff check . --fix'
alias e='exit'
alias reload='source ~/.zshrc; echo "🔄 zsh reloaded!"'
alias move='mv'
alias remove='rm -i'
alias rm_fold='rm -rf -d'

# === Utilities
alias lazy_git='/snap/bin/lazygit'
alias jq='jq .'
# === CLI Projects ===
alias st='streamlit run main.py'
alias calc='cd streamlit_apps/Exchange_Calculator'

# === Hand-made NeoVim Plugins ===
alias lazydevhelp='cd ~/Projects/LazyDeveloperHelper && source ~/Projects/ProjectsEnv/bin/activate && git switch dev'
alias gpt_coding="cd ~/Projects/GPTCodeNvim && source ~/Projects/ProjectsEnv/bin/activate"

# === Rython ===
alias rython='python3 ~/Projects/Rython/rython/test.py'
alias rython_dir="cd ~/Projects/Rython/ && source ~/Projects/ProjectsEnv/bin/activate"
alias build_rython="cd ~/Projects/Rython/ && source ~/Projects/ProjectsEnv/bin/activate && cd rython/jit/__rust__/ && cargo build --release && maturin develop --release"
alias move_rython_so='cd "$HOME/Projects/Rython/rython/jit/__rust__/target/release" && mv -f librython_jit.so rython_jit.so && mv -f rython_jit.so ../../../../../'

# === Telegram bots
alias telegram_bot='cd ~/Projects/bots/ && source ~/Projects/ProjectsEnv/bin/activate'
# === P10K ===
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

