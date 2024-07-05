-- -- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.x",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({ "catppuccin/nvim", as = "catppuccin" })
	-- use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate'" })
	use({ "nvim-treesitter/playground" })
	use({ "ThePrimeagen/harpoon" })
	use({ "mbbill/undotree" })
	use({ "tpope/vim-fugitive" })
	use({ "tpope/vim-dadbod" })
	use({ "kristijanhusak/vim-dadbod-ui" })
	use({ "kristijanhusak/vim-dadbod-completion" })
	-- use { 'preservim/nerdtree' }
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
	})
	use({ "L3MON4D3/LuaSnip" })
	use("preservim/nerdcommenter")
	use({ "ryanoasis/vim-devicons" })
	use({ "vim-airline/vim-airline" })
	use({ "vim-airline/vim-airline-themes" })
	use({
		"utilyre/barbecue.nvim",
		tag = "*",
		requires = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		after = "nvim-web-devicons", -- keep this if you're using NvChad
		config = function()
			require("barbecue").setup()
		end,
	})
	use("m4xshen/autoclose.nvim")
	-- use("editorconfig/editorconfig-vim")
	--use { 'tamton-aquib/flirt.nvim' }
	use("gpanders/editorconfig.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	-- packer
	use({
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	})
	use("nvim-telescope/telescope-project.nvim")
	-- use({
	--     "rest-nvim/rest.nvim",
	--     requires = { "nvim-lua/plenary.nvim" },
	--     config = function()
	--         require("rest-nvim").setup({
	--             -- Open request results in a horizontal split
	--             result_split_horizontal = false,
	--             -- Keep the http file buffer above|left when split horizontal|vertical
	--             result_split_in_place = false,
	--             -- Skip SSL verification, useful for unknown certificates
	--             skip_ssl_verification = false,
	--             -- Encode URL before making request
	--             encode_url = true,
	--             -- Highlight request on run
	--             highlight = {
	--                 enabled = true,
	--                 timeout = 150,
	--             },
	--             result = {
	--                 -- toggle showing URL, HTTP info, headers at top the of result window
	--                 show_url = true,
	--                 show_http_info = true,
	--                 show_headers = true,
	--                 -- executables or functions for formatting response body [optional]
	--                 -- set them to false if you want to disable them
	--                 formatters = {
	--                     json = "jq",
	--                     html = function(body)
	--                         return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
	--                     end,
	--                 },
	--             },
	--             -- Jump to request line on run
	--             jump_to_request = false,
	--             env_file = ".env",
	--             custom_dynamic_variables = {},
	--             yank_dry_run = true,
	--         })
	--     end,
	-- })
	use({ "kkharji/sqlite.lua" })
	use({
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension("frecency")
		end,
		requires = { "kkharji/sqlite.lua" },
	})
	use("vim-test/vim-test")
	use({ "toppair/peek.nvim", run = "deno task --quiet build:fast" })
	use({ "lvimuser/lsp-inlayhints.nvim" })
	use("folke/zen-mode.nvim")
	use({
		"tanvirtin/vgit.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use({ "stevearc/dressing.nvim" })
	use({ "nvim-telescope/telescope-ui-select.nvim" })
	use("timonv/vim-cargo")
	use({ "lewis6991/gitsigns.nvim" })
	use({
		"kevinhwang91/nvim-ufo",
		requires = {
			"kevinhwang91/promise-async",
		},
	})
	use({ "luukvbaal/statuscol.nvim" })
	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
	})
	use({ "tpope/vim-rhubarb" })
	use({ "m4xshen/smartcolumn.nvim" })
	-- use { 'mfussenegger/nvim-dap' }
	use({ "simrat39/rust-tools.nvim" })
	use({
		"neoclide/npm.nvim",
		requires = {
			"Shougo/denite.nvim",
		},
	})
	use("jbyuki/instant.nvim")
	use({
		"ruifm/gitlinker.nvim",
		requires = "nvim-lua/plenary.nvim",
	})

	-- Or with configuration
	use({
		"projekt0n/github-nvim-theme",
		branch = "0.0.x",
		config = function()
			require("github-theme").setup({
				-- ...
			})
		end,
	})
	use({ "mg979/vim-visual-multi", branch = "master" })
	use({
		"natecraddock/workspaces.nvim",
		config = function()
			local workspaces = require("workspaces")
			workspaces.setup()
		end,
	})
	use("Hoffs/omnisharp-extended-lsp.nvim")
	use("folke/trouble.nvim")
	use({ "puremourning/vimspector" })
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})
	use({
		"samodostal/image.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			{ "m00qek/baleia.nvim", tag = "v1.3.0" },
		},
	})
	use("nanotee/sqls.nvim")
	-- use({
	--     "jose-elias-alvarez/null-ls.nvim",
	--     requires = "nvim-lua/plenary.nvim",
	-- })
	-- use({ "jay-babu/mason-null-ls.nvim" })
	use({
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	})
	use("qnighy/lalrpop.vim")
	use("Decodetalkers/csharpls-extended-lsp.nvim")
	-- use({
	--     "glepnir/dashboard-nvim",
	--     event = "VimEnter",
	--     config = function()
	--         require("dashboard").setup({
	--             -- config
	--         })
	--     end,
	--     dependencies = { { "nvim-tree/nvim-web-devicons" } },
	-- })
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })
	use({ "VidocqH/lsp-lens.nvim" })
	use({ "nvim-telescope/telescope-media-files.nvim", requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" } })
	use("mattn/emmet-vim")
	use("lukas-reineke/indent-blankline.nvim")
	use("mhinz/vim-startify")
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
	use("semanticart/tag-peek.vim")
	use({
		"kndndrj/nvim-dbee",
		requires = {
			"MunifTanjim/nui.nvim",
		},
		run = function()
			-- Install tries to automatically detect the install method.
			-- if it fails, try calling it with one of these parameters:
			--    "curl", "wget", "bitsadmin", "go"
			require("dbee").install()
		end,
		config = function()
			require("dbee").setup( --[[optional config]])
		end,
	})
    use 'mfussenegger/nvim-lint'
end)
