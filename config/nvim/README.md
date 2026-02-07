# My Neovim Configuration

This configuration is designed to be minimal, yet powerful.

## Requirements

This configuration uses [mini.deps](https://github.com/nvim-mini/mini.deps) to maintain backward-compatibility
with Neovim 0.11.6. This configuration also has a number of external "dependencies" that are expected to be in $PATH somewhere.

| Tool              | Reason                   | How I installed it                       |
| ----------------- | ------------------------ | ---------------------------------------- |
| `codelldb`        | C: Debugging             | Mason                                    |
| `clangd`          | C: LSP                   | OS Package Manager                       |
| `clang-format`    | C: Formatting            | OS Package Manager                       |
| `shfmt`           | Bash: Formatting         | OS Package Manager                       |
| `basedpyright`    | Python: LSP              | `uv tool install basedpyright`           |
| `debugpy`         | Python: Debugging        | `uv tool install debugpy`                |
| `mypy`            | Python: LSP              | `uv tool install mypy`                   |
| `pylint`          | Python: LSP              | `uv tool install pylint`                 |
| `ruff`            | Python: LSP              | `uv tool install ruff`                   |
| `bash-ls`         | Bash: LSP                | `npm i -g bash-language-server`          |
| `prettier`        | Web: Formatting          | `npm i -g prettier`                      |
| `prisma-ls`       | Prisma: LSP              | `npm i -g @prisma/language-server`       |
| `vtsls`           | Web: LSP                 | `npm i -g @vtsls/language-server`        |
| `emmylua_ls`      | Lua: LSP                 | `cargo install --locked emmylua_ls`      |
| `neocmakelsp`     | CMake: LSP               | `cargo install --locked neocmakelsp`     |
| `stylua`          | Lua: Formatting          | `cargo install --locked stylua`          |
| `taplo`           | TOML: LSP                | `cargo install --locked taplo-cli`       |
| `tree-sitter-cli` | Tree-sitter: Compilation | `cargo install --locked tree-sitter-cli` |

## Installed Plugins

**Coding Plugins**

| **Plugin**                                                            | **Purpose**                |
| --------------------------------------------------------------------- | -------------------------- |
| [blink.cmp](https://github.com/sahgen/blink.cmp)                      | Autocompletion             |
| [conform.nvim](https://github.com/stevearc/conform.nvim)              | Formatting Registry        |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                        | Snippets                   |
| [mini.nvim](https://github.com/nvim-mini/mini.nvim)                   | QoL Plugins                |
| [neogen](https://github.com/danymat/neogen)                           | Auto Docstrings            |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap)                  | Debugging                  |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint)                | Linting Registry           |
| [nvim-lspconfig](https://github.com/nvim-lspconfig/nvim-lspconfig)    | Default LSP Configurations |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax Highlighting        |
| [oil.nvim](https://github.com/stevearc/oil.nvim)                      | File Navigation            |

**UI Plugins**

| **Plugin**                                                   | **Purpose**         |
| ------------------------------------------------------------ | ------------------- |
| [gitsigns](https://github.com/lewis6991/gitsigns.nvim)       | Git Version History |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status Bar          |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)       | Debugging UI        |

**Personal Plugins**

| **Plugin**                                           | **Purpose**         |
| ---------------------------------------------------- | ------------------- |
| [Wakatime](https://github.com/wakatime/vim-wakatime) | Developer Analytics |

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
