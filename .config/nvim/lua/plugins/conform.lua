local function format_hunks()
  local ignore_filetypes = { 'lua' }
  if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
    vim.notify('range formatting for ' .. vim.bo.filetype .. ' not working properly.')
    return
  end

  local hunks = require('gitsigns').get_hunks()
  if hunks == nil then
    return
  end

  local format = require('conform').format

  local function format_range()
    if next(hunks) == nil then
      vim.notify('done formatting git hunks', 'info', { title = 'formatting' })
      return
    end
    local hunk = nil
    while next(hunks) ~= nil and (hunk == nil or hunk.type == 'delete') do
      hunk = table.remove(hunks)
    end

    if hunk ~= nil and hunk.type ~= 'delete' then
      local start = hunk.added.start
      local last = start + hunk.added.count
      -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
      local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
      local range = { start = { start, 0 }, ['end'] = { last - 1, last_hunk_line:len() } }
      format({ range = range, async = true, lsp_fallback = true }, function()
        vim.defer_fn(function()
          format_range()
        end, 1)
      end)
    end
  end

  format_range()
end

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>f',
      function()
        require('conform').format { async = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
    {
      '<leader>cf',
      function()
        format_hunks()
      end,
      mode = 'n',
      desc = '[C]hanges [F]ormat',
    },
    {
      '<leader>F',
      function()
        if vim.b.disable_autoformat or vim.g.disable_autoformat then
          vim.cmd 'FormatEnable'
        else
          vim.cmd 'FormatDisable'
        end
      end,
      mode = 'n',
      desc = 'Toggle [F]ormat',
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      go = { 'goimports-reviser' },
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      html = { 'prettierd' },
      css = { 'prettierd' },
      json = { 'prettierd' },
      bash = { 'shfmt' },
      sh = { 'shfmt' },
      sql = { 'sqlfmt' },
      php = { 'pint', 'php-cs-fixer' },
      blade = { 'blade-formatter' },
      rustfmt = { 'rust' },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = 'fallback',
    },
    -- Set up format-on-save
    -- Disable autoformat on certain filetypes
    format_on_save = function(bufnr)
      local ignore_filetypes = { 'sql', 'java' }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
      end
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match '/node_modules/' then
        return
      end
      format_hunks()
      -- return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
