# dotfiles

Neovim + tmux configuration with sensible defaults for coding. Works on macOS and Linux (Ubuntu).

## What's Included

**Neovim** — Lua-based config with lazy.nvim

- LSP support via Mason (Python, TypeScript, Rust, Go, Lua, Bash, JSON, YAML)
- Autocompletion (nvim-cmp + LuaSnip + snippets)
- Treesitter syntax highlighting
- Telescope fuzzy finder
- Format-on-save (prettier, ruff, gofmt, rustfmt, stylua, shfmt)
- File tree (nvim-tree), git signs, statusline, which-key, autopairs, surround, comments, indent guides
- Catppuccin Mocha theme

**tmux** — prefix `C-a`, vim-style navigation, 256-color, TPM plugin manager

## Install

```bash
git clone git@github.com:aff0gat000/dotfiles.git
cd dotfiles
./install.sh
```

The install script will:

1. Install dependencies (neovim, tmux, ripgrep, fd, node, etc.)
2. Symlink configs to `~/.config/nvim` and `~/.config/tmux`
3. Run `Lazy sync` headless to install Neovim plugins

## Structure

```
├── install.sh
├── nvim/
│   ├── init.lua
│   └── lua/
│       ├── core/
│       │   ├── options.lua
│       │   └── keymaps.lua
│       └── plugins/
│           ├── colorscheme.lua
│           ├── completion.lua
│           ├── editor.lua
│           ├── formatting.lua
│           ├── lsp.lua
│           └── treesitter.lua
├── tmux/
│   └── tmux.conf
└── docs/
    └── keybindings.md
```

## Keybindings

Leader key: `Space`

| Key | Action |
|-----|--------|
| `<Space>ff` | Find files |
| `<Space>fg` | Live grep |
| `<Space>fk` | Search keybindings |
| `<Space>n` | Toggle file tree |
| `gd` | Go to definition |
| `gr` | Go to references |
| `<Space>ca` | Code action |
| `<Space>rn` | Rename symbol |
| `<Space>cf` | Format buffer |
| `gcc` | Toggle comment |

Press `<Space>` and wait for the which-key popup to see all available bindings.

Full reference: [docs/keybindings.md](docs/keybindings.md)

## Adding Language Servers

Edit `nvim/lua/plugins/lsp.lua` and add the server name to the `ensure_installed` list. Available servers: `:Mason` inside Neovim.

## Adding Formatters

Edit `nvim/lua/plugins/formatting.lua` and add entries to `formatters_by_ft`. Install formatters via Mason (`:Mason`) or your system package manager.
