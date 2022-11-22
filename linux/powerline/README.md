# Powerline

This is a simple guide to install `Powerline` to make your terminal look beautiful

Useful links:
* [Powerline GitHub](https://github.com/powerline/powerline)
* [Powerline Documentation](https://powerline.readthedocs.io/en/latest/)

## Instalation 

### Manjaro

```bash
$ sudo pacman -S powerline
```

### Ubuntu

```bash
$ sudo apt install powerline
```

## Configure Bash

To configure Powerline for bash, add the following lines to your `$HOME/.bashrc` file:

```bash
# Powerline configuration
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  source /usr/share/powerline/bindings/bash/powerline.sh
fi
```  

To apply the changes to your current terminal:

```bash
$ source ~/.bashrc
```

After running the previous command or restarting your terminal, the Powerline segments appear in your prompt.

## Configure Vim

To configure Powerline for Vim, add the following lines to your `$HOME/.vimrc` file:

```bash
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
```

## Configure tmux

To configure Powerline in tmux, add the following to your `~/.tmux.conf` file:

```bash
set -g default-terminal "screen-256color"
source "/usr/share/powerline/bindings/tmux/powerline.conf"
```
