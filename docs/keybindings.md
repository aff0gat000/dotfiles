# Keybindings

Leader key: `<Space>`

## General

| Key | Mode | Action |
|-----|------|--------|
| `<Space>w` | Normal | Save file |
| `<Esc>` | Normal | Clear search highlight |
| `<Space>p` | Visual | Paste without overwriting register |
| `<C-d>` | Normal | Scroll down (centered) |
| `<C-u>` | Normal | Scroll up (centered) |
| `J` | Visual | Move selected lines down |
| `K` | Visual | Move selected lines up |

## Windows & Buffers

| Key | Mode | Action |
|-----|------|--------|
| `<C-h/j/k/l>` | Normal | Navigate between windows |
| `<C-Up/Down/Left/Right>` | Normal | Resize windows |
| `<S-h>` | Normal | Previous buffer |
| `<S-l>` | Normal | Next buffer |
| `<Space>bd` | Normal | Delete buffer |

## File Navigation (Telescope)

| Key | Mode | Action |
|-----|------|--------|
| `<Space>ff` | Normal | Find files |
| `<Space>fg` | Normal | Live grep |
| `<Space>fb` | Normal | List buffers |
| `<Space>fh` | Normal | Help tags |
| `<Space>fr` | Normal | Recent files |
| `<Space>fd` | Normal | Diagnostics |

## File Tree

| Key | Mode | Action |
|-----|------|--------|
| `<Space>n` | Normal | Toggle file tree |

## LSP

| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gr` | Normal | Go to references |
| `gi` | Normal | Go to implementation |
| `K` | Normal | Hover documentation |
| `<Space>ca` | Normal | Code action |
| `<Space>rn` | Normal | Rename symbol |
| `<Space>D` | Normal | Type definition |
| `[d` / `]d` | Normal | Previous / next diagnostic |
| `<Space>e` | Normal | Show diagnostic float |

## Formatting

| Key | Mode | Action |
|-----|------|--------|
| `<Space>cf` | Normal | Format buffer |
| *(automatic)* | — | Format on save |

## Editing

| Key | Mode | Action |
|-----|------|--------|
| `gcc` | Normal | Toggle comment (line) |
| `gc` | Visual | Toggle comment (selection) |
| `ys{motion}{char}` | Normal | Add surrounding |
| `ds{char}` | Normal | Delete surrounding |
| `cs{old}{new}` | Normal | Change surrounding |

## Completion (Insert Mode)

| Key | Mode | Action |
|-----|------|--------|
| `<Tab>` | Insert | Next completion / expand snippet |
| `<S-Tab>` | Insert | Previous completion |
| `<CR>` | Insert | Confirm completion |
| `<C-Space>` | Insert | Trigger completion |
| `<C-e>` | Insert | Abort completion |
| `<C-b>` / `<C-f>` | Insert | Scroll docs |

## Viewing Keybindings Inside Neovim

1. **which-key popup** — press `<Space>` and wait; a popup shows all leader bindings
2. **Telescope keymap search** — `:Telescope keymaps` to fuzzy-search all mappings
3. **Built-in** — `:map` (all), `:nmap` (normal), `:imap` (insert), `:vmap` (visual)

---

## Tmux

Prefix: `C-a` (Ctrl+a)

| Key | Action |
|-----|--------|
| `C-a \|` | Split pane horizontally |
| `C-a -` | Split pane vertically |
| `C-a h/j/k/l` | Navigate panes (vim-style) |
| `C-a H/J/K/L` | Resize panes |
| `C-a c` | New window |
| `C-a r` | Reload config |
| `C-a [` | Enter copy mode (vi keys) |
| `v` | Begin selection (in copy mode) |
| `y` | Yank selection (in copy mode) |

To list all tmux bindings: `tmux list-keys` or `C-a ?`

---

# How to Add Custom Keybindings

## Neovim

Add mappings in `nvim/lua/core/keymaps.lua`:

```lua
-- Pattern:
vim.keymap.set("mode", "key", action, { desc = "Description" })

-- Examples:
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
```

Modes: `"n"` (normal), `"i"` (insert), `"v"` (visual), `"x"` (visual block), `"t"` (terminal), `""` (all).

For plugin-specific keymaps, add a `keys` table in the plugin spec (see `nvim/lua/plugins/editor.lua` for examples). These also lazy-load the plugin on keypress.

## Tmux

Add bindings in `tmux/tmux.conf`:

```bash
# Pattern:
bind <key> <command>

# Examples:
bind g new-window -n "lazygit" lazygit    # C-a g opens lazygit
bind -r Tab next-window                    # C-a Tab cycles windows
bind S command-prompt -p "Session:" "new-session -s '%%'"
```

Use `-r` for repeatable bindings. Reload with `C-a r`.
