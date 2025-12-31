return {
	{ "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-tree/nvim-tree.lua", version = "*", lazy = false, dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
        "hrsh7th/nvim-cmp",
        dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/nvim-cmp" },
            { "L3MON4D3/LuaSnip", },
            { "saadparwaiz1/cmp_luasnip" },
        },
    },
	{
	  "L3MON4D3/LuaSnip",
	  dependencies = { "rafamadriz/friendly-snippets" },
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{"OXY2DEV/markview.nvim", lazy = false},
	{"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
	{"rose-pine/neovim", name = "rose-pine"},
	{"f-person/auto-dark-mode.nvim",},
}
