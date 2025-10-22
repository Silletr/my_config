# --- PATH ---
set -gx PATH $HOME/.local/share/omf/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH /usr/bin $PATH
set -gx PATH /opt/nvim-linux-x86_64/bin $PATH
set -gx PATH $HOME/.local/share/gem/ruby/3.2.0/bin $PATH
set -gx PATH $HOME/bin $PATH
set -gx PATH /home/silletr/.spicetify $PATH
set -gx PATH /snap/bin $PATH

# --- Starship prompt ---
starship init fish | source

status --is-interactive; and omf theme bobthefish

if status --is-interactive
    # Aliases
    alias gst='git status'
    alias gcm='git commit -m'
    alias gac='git add .; git commit'
    alias gp='git push origin'
    alias gpl='git pull origin'
    alias gbc='git switch'
    alias reload='exec fish echo "🔄 Reloaded!"'
    alias c='clear'
    alias format_ruff='ruff check . --fix'
    alias move='mv'
    alias remove='rm -i'
    alias rm_fold='rm -rf -d'
    alias lazy_git='/snap/bin/lazygit'
    alias st='streamlit run main.py'
    alias calc='cd streamlit_apps/Exchange_Calculator'
    alias lazydevhelp='cd ~/.config/nvim/lua/LazyDeveloperHelper; source ~/Projects/ProjectsEnv/bin/activate.fish'
    alias SilleOs='cd SaillOs; gst; git pull'
    alias e='exit'

    # Theme setting
    source ~/.config/fish/themes/tokyonight_storm.fish

  
end

