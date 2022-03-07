# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Codespaces bash prompt theme
__bash_prompt() {
    local userpart='`echo -n "\[\033[0;32m\]justin-dev"`'
    local gitbranch='`\
        if [ "$(git config --get codespaces-theme.hide-status 2>/dev/null)" != 1 ]; then \
            export BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null); \
            if [ "${BRANCH}" != "" ]; then \
                echo -n "\[\033[0;36m\](\[\033[1;31m\]${BRANCH}" \
                && if git ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
                        echo -n " \[\033[1;33m\]✗"; \
                fi \
                && echo -n "\[\033[0;36m\]) "; \
            fi; \
        fi`'
    local lightblue='\[\033[1;34m\]'
    local removecolor='\[\033[0m\]'
    PS1="${userpart} ${lightblue}\w ${gitbranch}${removecolor}\$ "
    unset -f __bash_prompt
}
__bash_prompt

# Custom settings
source /usr/share/bash-completion/completions/git

# Custom aliases
alias start="cd /workspaces/obsidian && tmuxinator start vanta -p ~/.vanta-tmux.yml"
alias pull="cd /workspaces/obsidian && git pull --rebase origin main && make generate-types"
alias types="cd /workspaces/obsidian && make generate-types"
alias grc="git add . && git rebase --continue"
alias gra="git rebase --abort"
alias cdo="cd /workspaces/obsidian"

# Custom functions
function ga() {
    git add "$@";
}
function gcam() {
    git commit -am "$1";
}
function gcamp() {
    git commit -am "$1";
    git push;
}
