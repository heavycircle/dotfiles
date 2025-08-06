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

## Configurations

I use the following stack:

1. Bash - The latest version
    - I am using `bashplug`, a hand-written plugin management system, for 
      holding my bash plugins. There aren't that many at the moment. The
      ones inside are copies of core oh-my-zsh plugins that I missed when
      I migrated back to bash.
2. Neovim - The nightly release
    - My current Neovim configuration **only** works on the nightly release.
      0.12.0-dev introduced a native package manager that removed my need for
      a LazyVim-based configuration.
3. Tmux - At least v3.5
    - The current configuration uses tpm for plugin management. I'm not sure
      how much longer I'll keep it around because I want almost my entire 
      configuration to be hand-written. It brings a lot of bloat I just don't
      need.

I use Catppuccin Mocha for my theme wherever reasonable.

