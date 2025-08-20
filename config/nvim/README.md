# My Neovim Configuration

This configuration is designed to be minimal, yet powerful.

## Requirements

As of August 20, 2025, this configuration requires use of the Neovim nightly release to take advantage of Neovim's built-in package manager. I'm a really big fan (not to dig on lazy.nvim). My configuration is many times smaller.

I maintain the nightly release using [bob.nvim](https://github.com/MordechaiHadad/bob).

## Installed Plugins

Major Plugins

| **Plugin**                                                            | **Purpose**                |
| --------------------------------------------------------------------- | -------------------------- |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)          | Status Bar                 |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                        | Snippets                   |
| [mason.nvim](https://github.com/mason-org/mason.nvim)                 | LSP/Formatter Installation |
| [nvim-lspconfig](https://github.com/nvim-lspconfig/nvim-lspconfig)    | Default LSP Configurations |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax Highlighting        |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)   | Icon Support               |
| [oil.nvim](https://github.com/stevearc/oil.nvim)                      | File Navigation            |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)              | Dependency for Telescope   |
| [ripgrep](https://github.com/BurntSushi/ripgrep)                      | Dependency for Telescope   |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)    | Find things Faster         |

Personal Plugins

| **Plugin**                                           | **Purpose**                      |
| ---------------------------------------------------- | -------------------------------- |
| [showkeys](https://github.com/NvChad/showkeys)       | Prints keystrokes (for teaching) |
| [Wakatime](https://github.com/wakatime/vim-wakatime) | Developer Analytics              |

Colorschemes

| **Plugin**                                                    | **Purpose**         |
| ------------------------------------------------------------- | ------------------- |
| [catppuccin-mocha](https://github.com/catppuccin/nvim)        | Developer Analytics |
| [matteblack.nvim](https://github.com/tahayvr/matteblack.nvim) | Developer Analytics |
| [ronin.nvim](https://github.com/heavycircle/ronin.nvim)       | Developer Analytics |

## Changing How I Neovim

Every so often I find a new thing that fully changes how I Neovim. Since switching to `vim.pack`, I looked at all my plugins and decided what I did and didn't like and made a lot of decisions.  More often than not, I went with the minimal plugin choice. I stayed with plugins that did small things *really well*. If you look at [folke's dotfiles](https://github.com/folke/dot/tree/master/nvim), he has like 50+ plugins. Sure, he probably wrote half of them, but still.

Most of the UI "nice-to-haves" were the first things to go. `noice.nvim`, `nvim-notify`, `neo-tree`, etc. I'm somewhat a fan of the default Neovim look.

I was a tmux-er first, so most of the buffer-related things went away next. `nvim-bufferline.lua`, `vim-tmux-navigator`, etc. I'd rather just open a new tmux pane and have a vim tab there. I found buffers are too annoying to deal with. Let one Neovim window be for one editor.

> That second one doesn't make much sense, but since I'm not using Neovim buffers, I don't really need it.

The only thing I can say I *sometimes* miss is autocomplete. Especially with new languages and frameworks. But, diagnostics/LSP save the day *most* of the time.

Oil is slowly becoming my favorite plugin in the list, followed by LuaSnip. I'm still new at LuaSnip and it's not fully configured for all my use cases, but even already it has me moving faster than ever.
