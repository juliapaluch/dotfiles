require('statusline')

-- how many columns a tab char takes up
vim.opt.tabstop = 4

-- num spaces for one level indent
vim.opt.shiftwidth = 4

-- for easier navigation
vim.opt.number = true
vim.opt.relativenumber = true

-- display signs in number column
vim.opt.signcolumn = "number"

-- change of end of buffer char
vim.opt.fillchars = { eob = "·" }

-- set up lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
   vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- assign space as leader key
vim.g.mapleader = " "

require("lazy").setup({
  spec = { { import = "plugins" },},
  defaults = { lazy = false, version = false, },
  checker = { enabled = true, notify = false,},
})

-- switch light/dark theme based on system theme
require("auto-dark-mode").setup({
  update_interval = 1000,
  set_dark_mode = function()
	vim.o.background = 'dark'
    vim.cmd("colorscheme rose-pine-main")
  end,
  set_light_mode = function()
	vim.o.background = 'light'
    vim.cmd("colorscheme rose-pine-dawn")
  end,
})

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
		require('luasnip').lsp_expand(args.body)
	end,
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['q'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
  sources = cmp.config.sources(
	  {
        { name = 'nvim_lsp' },
      }
  )
})

require("luasnip.loaders.from_vscode").lazy_load()

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('lua_ls', {
	capabilities = capabilities,
	settings = { Lua = { diagnostics = { globals = { "vim" } } } }
})
vim.lsp.enable('lua_ls')

vim.lsp.config('clangd', {
	capabilities = capabilities,
})
vim.lsp.enable('clangd')

require("nvim-treesitter").setup({
  ensure_installed = { "cpp", "lua" }
})

vim.diagnostic.config({
  float = {
    border = "rounded",
  },
  underline = true,
})

local telescope = require("telescope.builtin")
vim.keymap.set('n', '<leader>/', telescope.live_grep)
vim.keymap.set('n', '<leader>ff', telescope.find_files)

require("nvim-tree").setup({
  view = {
	-- sidebar should automatically fit width to visible file names
	adaptive_size = true,
  },
})

local tree = require("nvim-tree.api")
vim.keymap.set('n', '<leader>b', tree.tree.toggle)

-- easily navigate split panes
vim.keymap.set('n', '<leader>l', '<C-w>l', { desc = "Move pane focus right" } )
vim.keymap.set('n', '<leader>h', '<C-w>h', { desc = "Move pane focus left" } )
vim.keymap.set('n', '<leader>k', '<C-w>k', { desc = "Move pane focus up" } )
vim.keymap.set('n', '<leader>j', '<C-w>j', { desc = "Move pane focus down" } )


-- show diagnostic window
vim.keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float()
end, { desc = "Show diagnostics for current line" })
