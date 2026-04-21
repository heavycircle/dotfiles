# heavycircle's Dotfiles

This is what I use day-to-day. It should be portable to most machines.

## Installation

```bash
git clone https://github.com/heavycircle/dotfiles ~/dotfiles
cd ~/dotfiles
./sync push
```

The `sync` bash script syncs the important tracked files to/from their
home locations within your configuration directories. You can easily edit
the files tracked via `sync`.

Use `./sync pull` to pull changes from your config directories into the
dotfiles folder.

> _Note: Future commits here will remove the Hyprland suite. I moved away
> from Hyprland after not using it to its full potential. I'm a tmux user
> first. I don't really use a tiling window manager the way I should, so
> it offers more annoyance than convenience._

## Configurations

I use the following stack:

1. Bash - The latest version
      - Still using GNU readline with vi mode (see [inputrc](./inputrc)).
        Nothing fancy, just pure bash. I just like it.
2. Neovim - At least v0.12.0 (`latest`)
      - This configuration uses `vim.pack` for package management, which only
        exists in nvim 0.12.0. @echasnovski provides a good bridge in his nvim
        configuration for older versions of nvim.
3. Tmux - At least v3.5
      - Expects a custom theme at `themes/current.conf` for the custom prompt.
        I'll spend more time minimizing how much code actually needs to go into
        this file, but it's a patchwork solution for now.

## Theme

I got bored of the same theme wherever I went, so I implemented theme switching.
You can see this inside [theme](config/bash/theme). This script allows you to
change the theme of the major applications with one command.

The available themes are inside [config/theme](./config/theme). Other programs
reference [current](./config/theme/current) whose symlink is changed each time
the theme is switched. Most applications require restart.
