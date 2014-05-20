install: z
	./install.sh

z:
	-[ -e bin/z ] || git clone https://github.com/rupa/z.git ~/.dotfiles/z
	-[ -e bin/z ] || cp z/z.sh z/z.bash

.PHONY: install
