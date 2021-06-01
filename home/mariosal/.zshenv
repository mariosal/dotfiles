eval $(/opt/homebrew/bin/brew shellenv)

#export PATH=$PATH:$HOME/go/bin:$HOME/.cargo/bin
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export RUBY_CONFIGURE_OPTS=--disable-install-doc
export EDITOR="code -w"
export CC=clang
export CXX=clang++
export CFLAGS="-O3 -pipe -flto=thin"
export CXXFLAGS="-O3 -pipe -stdlib=libc++ -flto=thin"
export LDFLAGS="-O3 -pipe -stdlib=libc++ -flto=thin"
