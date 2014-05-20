install: z git-prompt
	./install.sh

z:
	-[ -e z/z.bash ] || git clone https://github.com/rupa/z.git ~/.dotfiles/z
	-[ -e z/z.bash ] || cp z/z.sh z/z.bash


bash-git-prompt:
	git clone https://github.com/magicmonty/bash-git-prompt.git ~/.dotfiles/bash-git-prompt

git-prompt: bash-git-prompt

.PHONY: install
