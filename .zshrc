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
alias move='mv'
alias remove='rm -i'
alias rm_fold='rm -rf -d'

alias lazy_git='/snap/bin/lazygit'
alias st='streamlit run main.py'
alias calc='cd streamlit_apps/Exchange_Calculator'
alias lazydevhelp='cd ~/.config/nvim/lua/LazyDeveloperHelper; source ~/Projects/ProjectsEnv/bin/activate; git switch dev'
alias SilleOs='cd SaillOs; gst; git pull'
alias e='exit'
alias reload='source ~/.zshrc; echo "🔄 zsh reloaded!"'

# === P10K ===
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
