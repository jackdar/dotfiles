-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
-- vim.opt.showmode = true

-- Set highlight on search
vim.opt.hlsearch = false

-- Set termguicolors to enable highlighting
vim.opt.termguicolors = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 4

-- Disable text wrapping
vim.opt.wrap = false

-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Don't split words
vim.opt.linebreak = true

-- The number of spaces inserted for each indentation (default: 8)
vim.opt.shiftwidth = 4

-- Insert n spaces for a tab (default: 8)
vim.opt.tabstop = 4

-- Number of spaces that a tab counts for while performing editing operations (default: 0)
vim.opt.softtabstop = 4

-- Convert tabs to spaces (default: false)
vim.opt.expandtab = true

-- Enable auto-indentation
-- vim.opt.autoindent = true

-- Minimum number of screen columns either side of the cursor
vim.opt.sidescrolloff = 8

-- Insert mode cursor as block
-- vim.opt.guicursor = 'n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,i:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s).
vim.opt.confirm = true
