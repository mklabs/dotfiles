*dotfiles*

> Arch Linux Manjaro / Gnome shell / i3wm / Termite / Fish / Oh My Fish / Paper theme / ag, fzf, z ...

     ██████████████████  ████████     mk@manjaro
     ██████████████████  ████████     OS: Manjaro 15.12 Capella
     ██████████████████  ████████     Kernel: x86_64 Linux 4.1.21-1-MANJARO
     ██████████████████  ████████     Uptime: 1h 57m
     ████████            ████████     Packages: 1294
     ████████  ████████  ████████     Shell: fish
     ████████  ████████  ████████     Resolution: 5760x2160
               ████████  ████████     DE: Gnome
     ████████  ████████  ████████     WM: GNOME Shell
     ████████  ████████  ████████     WM Theme: Adwaita
     ████████  ████████  ████████     GTK Theme: Paper [GTK2/3]
     ████████  ████████  ████████     Icon Theme: Paper
     ████████  ████████  ████████     Font: Roboto 11
     ████████  ████████  ████████     CPU: AMD FX-6300 Six-Core @ 3.5GHz
     ████████  ████████  ████████     GPU: GeForce GTX 960
     ████████  ████████  ████████     RAM: 2100MiB / 7872MiB
     ████████  ████████  ████████


![desktop][./desktop.png]


**Wallpaper**: http://www.zastavki.com/pictures/originals/2015/Backgrounds_Totoro__gray_background_104137_.png
**Terminal**: [Termite](https://github.com/thestinger/termite) with
[Fish](https://fishshell.com/) / [Oh My
Fish](https://github.com/oh-my-fish/oh-my-fish),
[pure](https://github.com/rafaelrinaldi/pure) theme and
[Roboto](https://www.google.com/fonts/specimen/Roboto) font.

## Install

This is a backup of my dot/config files. [bin/] directory includes scripts to
setup the environment from scratch and can be used to bootstrap a fresh
installation.

```sh
git clone git://github.com/mklabs/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

You'll get prompted for each symlink.

### Overview

- **config/** files are loaded on shell startup
- **bin/** Install scripts
- Every other folder gets symlinked to ~/.config (termite -> ~/.config/termite)
- install.sh asks for each symlinks before doing so

### Distrib

[bin/distrib dir](bin/distrib) contains installation script for various
distribution. It goes a little bit beyond the idea of dotfiles, and setup a new
fresh distrib with all the softwares that I use, going from desktop
environment, display manager to theme and terminal.

To run an install script, simply execute the according file for the platform:

    $ ./bin/manjaro

They commonly install the following

		gnome 3       - Desktop environment
    i3-wm         - Windows manager with great customization capability

    termite       - Lightweight, keyboard centric terminal
    fish          - Awesome little shell like zsh, with great autocompletion feature
    oh-my-fish    - oh-my-zsh equivalent for fish

    arc theme     - A popular and well designed theme for Gnome
    flattr icon   - Set of icons for theming gtk
    Roboto        - The Material Design font for System font
    Font Awesome  - For the multitude of icons it provides

		ag						- A much better version of grep / ack
		fzf						- fuzzy file finder
		z							- https://github.com/rupa/z

    neovim / vim  - Vim is my text editor of choice, neovim if a fork that brings real async I/O and a great terminal emulator.

    chrome        - For browsing / frontend dev

    spotify       - To listen for some good music

I recently switched from Ubuntu gnome to Manjaro. The ubuntu script may be a bit behind.

---

**todos**

- rofi / compiz
- i3wm config
