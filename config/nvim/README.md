# My Neovim Configuration

This configuration is designed to be minimal, yet powerful.

## Requirements

This configuration uses the [Neovim default package manager](https://github.com/neovim/neovim/pull/34009). Therefore, you'll need to install Neovim nightly release if you want to use this. I maintain the nightly release using [bob.nvim](https://github.com/MordechaiHadad/bob).

This configuration also has a number of external "dependencies" that are expected to be in $PATH somewhere.

| Tool           | Reason            | How I installed it             |
| -------------- | ----------------- | ------------------------------ |
| `clangd`       | C: LSP            | OS Package Manager             |
| `clang-format` | C: Formatting     | OS Package Manager             |
| `codelldb`     | C: Debugging      | Mason                          |
| `debugpy`      | Python: Debugging | `uv tool install debugpy`      |
| `basedpyright` | Python: LSP       | `uv tool install basedpyright` |
| `mypy`         | Python: LSP       | `uv tool install mypy`         |
| `ruff`         | Python: LSP       | `uv tool install ruff`         |
| `pylint`       | Python: LSP       | `uv tool install pylint`       |
| `prettier`     | Web: Debugging    | Mason                          |
| `vtsls`        | Web: LSP          | Mason                          |

## Installed Plugins

**Major Plugins**

| **Plugin**                                                            | **Purpose**                |
| --------------------------------------------------------------------- | -------------------------- |
| [blink.cmp](https://github.com/sahgen/blink.cmp)                      | Autocompletion             |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)          | Status Bar                 |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                        | Snippets                   |
| [mason.nvim](https://github.com/mason-org/mason.nvim)                 | LSP/Formatter Installation |
| [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)             | Bridging non-native LSPs   |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap)                  | Debugging                  |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)                | Debugging UI               |
| [nvim-lspconfig](https://github.com/nvim-lspconfig/nvim-lspconfig)    | Default LSP Configurations |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax Highlighting        |
| [oil.nvim](https://github.com/stevearc/oil.nvim)                      | File Navigation            |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)    | Find things Faster         |

**Dependency Plugins**

| **Plugin**                                                          | **Purpose**              |
| ------------------------------------------------------------------- | ------------------------ |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Icon Support             |
| [nvim-nio](https://github.com/nvim-neotext/nvim-io)                 | Dependency for DapUI     |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)            | Dependency for Telescope |
| [ripgrep](https://github.com/BurntSushi/ripgrep)                    | Dependency for Telescope |

**Personal Plugins**

| **Plugin**                                             | **Purpose**                      |
| ------------------------------------------------------ | -------------------------------- |
| [gitsigns](https://github.com/lewis6991/gitsigns.nvim) | Git Version History              |
| [showkeys](https://github.com/NvChad/showkeys)         | Prints keystrokes (for teaching) |
| [Wakatime](https://github.com/wakatime/vim-wakatime)   | Developer Analytics              |
| [which-key](https://github.com/folke/which-key.nvim)   | Keybind Lists (because I forget) |

**Colorschemes**

| **Plugin**                                                    | **Purpose** |
| ------------------------------------------------------------- | ----------- |
| [catppuccin-mocha](https://github.com/catppuccin/nvim)        | Colorscheme |
| [matteblack.nvim](https://github.com/tahayvr/matteblack.nvim) | Colorscheme |
| [ronin.nvim](https://github.com/heavycircle/ronin.nvim)       | Colorscheme |

## My Opinion

The goal of this configuration is to maintain Neovim's speed while ensuring a powerful environment. There was a point where I stopped using Neovim in favor of VSCode's LSP support and cool built-in features. Happy to be back.

There are a few things I intentionally leave out of my configuration. Notably, NeoTree and Bufferline are two big ones. I don't like splitting Neovim windows, nor do I like having multiple tabs. I use Oil to change files, and Tmux to handle my windows and sessions. This isn't for everyone, but _I'm faster this way and that's what really matters_. I was a tmux-er first so that workflow comes more naturally.

I brought autocomplete back into the setup after a long debate. It's just too useful. It never auto-accepts, only shows up when I want to, and mainly serves as a more targeted LSP. Never will I ever put an AI in here.
