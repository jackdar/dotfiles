-- [[ Keymaps ]]
--  See `:help vim.keymap.set()`
--
local opts = { noremap = true, silent = true }

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Quick save the current buffer
vim.keymap.set('n', '<leader>w', ':w %<CR>', opts)

-- Move command to move lines in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Keep the cursor in the same place when joining lines
vim.keymap.set('n', 'J', 'mzJ`z', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Make executable
vim.keymap.set('n', '<leader>x', ':!chmod +x %<CR>', opts)

-- Source current file
vim.keymap.set('n', '<leader><leader>x', ':source %<CR>', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv')

-- Keep last yanked when pasting
vim.keymap.set('x', '<leader>p', '"_dP', opts)

-- Yank into system clipboard
vim.keymap.set('n', '<leader>y', '"+y', opts)
vim.keymap.set('v', '<leader>y', '"+y', opts)
vim.keymap.set('n', '<leader>Y', '"+Y', opts)

-- Stay in visual mode after indenting
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd> set wrap! <CR>', opts)

-- Set keymaps for buffer management
vim.keymap.set('n', '<leader>bx', ':bd!<CR>', opts)
vim.keymap.set('n', '<leader>bc', '<cmd> enew <CR>', opts)

-- Toggle find and replace for the word under the cursor in the current buffer
vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', opts)

-- Toggle find and replace, deleting the word under the cursor in the current buffer.
vim.keymap.set('n', '<leader>sd', ':%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>', opts)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Open a new terminal buffer below in a horizontal split
vim.keymap.set('n', '<leader>st', function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.startinsert()
  vim.api.nvim_win_set_height(0, 10)
end, opts)

-- Open a new terminal buffer to the right in a vertical split
vim.keymap.set('n', '<leader>sv', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.startinsert()
  vim.api.nvim_win_set_width(0, 40)
end, opts)

-- Run make build quickly
vim.keymap.set('n', '<leader>m', ':make build<CR>', opts)
vim.keymap.set('n', '<leader>M', ':make run<CR>', opts)

local isLspDiagnosticsVisible = true
vim.keymap.set('n', '<leader>lx', function()
  isLspDiagnosticsVisible = not isLspDiagnosticsVisible
  vim.diagnostic.config {
    virtual_text = isLspDiagnosticsVisible,
    underline = isLspDiagnosticsVisible,
  }
end)
