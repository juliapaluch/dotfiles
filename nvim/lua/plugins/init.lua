return {
	{ "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-tree/nvim-tree.lua", version = "*", lazy = false, dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "L3MON4D3/LuaSnip", },
            { "saadparwaiz1/cmp_luasnip" },
        },
    },
	{
	  "L3MON4D3/LuaSnip",
	  dependencies = { "rafamadriz/friendly-snippets" },
	},
	{"OXY2DEV/markview.nvim", lazy = false},
	{"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
	{"rose-pine/neovim", name = "rose-pine"},
	{"f-person/auto-dark-mode.nvim",},
}
