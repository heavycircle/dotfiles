# heavycircle's Dotfiles

This is what I use day-to-day. It should be portable to most machines.

## Installation

``` bash
git clone https://github.com/heavycircle/dotfiles ~/dotfiles
cd ~/dotfiles
./sync push
```

The `sync` bash script syncs the important tracked files to/from their home
locations within your configuration directories. You can easily edit the files
tracked via `sync`.

Use `./sync pull` to pull changes from your config directories into the dotfiles
folder.

## Configurations

I have to different stacks based on my work environment. They're meant to act
very similarly.

1.  Terminal Setup

- *Option 1*: Alacritty + `tmux`. This is my original setup and the one I've
  been using for many years. Any terminal emulator can replace Alacritty here,
  but Alacritty is minimal, `cargo`-installable, and has minimal issues.
- *Option 2*: Wezterm. Wezterm natively supports multiplexing with the easy
  added benefit of multiplexing inside SSH domains with minimal configuration.
  It also comes with over a thousand custom colorschemes with easy dynamic
  management. I still have some upgrading to do to my config, namely with
  session management like my `tmux-sessioneer` script.

2.  Shell

- Both configurations use `fish >= 4.3.0`. This version added support for
  dynamic colorscheme registration and added more native colorschemes (i.e.,
  `catppuccin-mocha`).

3.  Editor

- Both configurations use `neovim` as the text editor. My two environments use
  different versions. One uses `nvim 0.11.6` and the other uses `nvim 0.12.3`.
  `nvim 0.12.0` is the start of native package management; the original config
  uses `mini.deps` for package management, and the latter uses the native
  `vim.pack` interface.

## Theme

I got bored of the same theme wherever I went, so I implemented theme switching.
You can see this inside [theme]. This script allows you to change the theme of
the major applications with one command.

The available themes are inside [config/theme]. Other programs reference
[current] whose symlink is changed each time the theme is switched. Most
applications require restart.

  [theme]: config/bash/theme
  [config/theme]: ./config/theme
  [current]: ./config/theme/current
