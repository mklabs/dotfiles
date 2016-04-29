
all: install

install:
	./install.sh

uninstall:
	stow -v -t $(HOME) -D fish
	stow -v -t $(HOME) -D git
	stow -v -t $(HOME) -D gtk
	stow -v -t $(HOME) -D i3
	stow -v -t $(HOME) -D i3blocks
	stow -v -t $(HOME) -D nyaovim
	stow -v -t $(HOME) -D termite
	stow -v -t $(HOME) -D wallpapers
	stow -v -t $(HOME) -D X11
