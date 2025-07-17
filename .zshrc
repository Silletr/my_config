# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path settings
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/usr/bin"

# Java setup
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

# Python path
export PYTHONPATH="$HOME/.pythonrc:$PYTHONPATH"

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Completion settings
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 'di=36'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Git aliases
alias gst='git status'
alias gcm='git commit -m'

alias gac='git add . && git commit'
alias gp='git push origin'

alias gpl='git pull origin'
alias gbc='git switch'

alias gmb='git merge origin'

# System aliases
alias reload='source ~/.zshrc'
alias c='clear'

alias format_ruff='ruff check . --fix && ruff format .'
alias move='mv'

alias remove='rm -i'
alias rm_fold='rm -rf'

# Application-specific aliases
alias lazy_git='/snap/bin/lazygit'
alias st='streamlit run main.py'

alias calc='cd streamlit_apps/Exchange_Calculator'
alias lazydevhelp='cd ~/.config/nvim/lua/LazyDeveloperHelper && source LazyEnv/bin/activate && git switch dev'

alias e='exit'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
