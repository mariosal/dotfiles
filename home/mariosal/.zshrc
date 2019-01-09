# If you come from bash you might have to change your $PATH.
export PATH=/usr/lib/llvm-7/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/mariosal/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gentoo"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(bundler copyfile emacs extract gitfast git-extras gitignore nvm rails rbenv thefuck)

source $ZSH/oh-my-zsh.sh

# User configuration

export CC=clang
export CXX=clang++
export AR=llvm-ar
export NM=llvm-nm
export RANLIB=llvm-ranlib
export CFLAGS="-march=native -O3 -pipe -flto=thin"
export CXXFLAGS="-march=native -O3 -pipe -stdlib=libc++ -flto=thin"
export LDFLAGS="-march=native -O3 -pipe -stdlib=libc++ -flto=thin -fuse-ld=lld"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH=/home/mariosal/.ssh/id_rsa

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

cl() {
  $CC ${=CPPFLAGS} ${=CFLAGS} ${=LDFLAGS} -pedantic-errors -std=c11 -g -Weverything $@ ${=LDLIBS}
}

ccl() {
  $CXX ${=CPPFLAGS} ${=CXXFLAGS} ${=LDFLAGS} -pedantic-errors -std=c++11 -g -Weverything $@ ${=LDLIBS}
}

upgrade() {
  sudo zsh -c 'apt update && apt -y full-upgrade && apt -y autoremove && apt -y clean && update-command-not-found && fwupdmgr refresh && fwupdmgr update'
  upgrade_oh_my_zsh
  cd ~/.nvm && gl
  cd ~/.rbenv && gl
  cd ~/.rbenv/plugins/ruby-build && gl
  cd ~/yogurt && bufo reset
  gem update --system
  gem update bundler rubocop fasterer
  tldr --update
  ncu -g
  rbenv install --list | grep -P " 2.3.*$" | tail -1 | grep -v "2.3.8$"
  nvm ls-remote | grep "Latest LTS: Carbon" | grep -v '\->'
}

fontclear() {
  sudo zsh -c 'fc-cache -f && dpkg-reconfigure fontconfig'
  fc-cache -f
  rm -rf ~/.cache/fontconfig
}

alias rm='rm -i'
alias l="ls -lah --group-directories-first"
alias val='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose'
alias by='bi && yarn'
alias rs='rails server -b 0.0.0.0'
alias ys='bin/webpack-dev-server'
alias o='xdg-open'
alias diff='colordiff'
alias stg='ssh wowbagger@vms.skroutz.gr'

alias yo='cd ~/yogurt'

source /usr/share/doc/fzf/examples/key-bindings.zsh

if [ -n "$DESKTOP_SESSION" ];then
  eval $(gnome-keyring-daemon --start)
  export SSH_AUTH_SOCK
fi
