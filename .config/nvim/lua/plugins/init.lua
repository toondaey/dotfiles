return {{
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
        library = { -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        {
            path = "luvit-meta/library",
            words = {"vim%.uv"}
        }}
    }
}, {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    keys = {{
        "<leader>?",
        function()
            require("which-key").show({
                global = false
            })
        end,
        desc = "Buffer Local Keymaps (which-key)"
    }}
}, {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    priority = 1000,
    config = true
}, "puremourning/vimspector", {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
}, -- "ThePrimeagen/harpoon", 
-- "mbbill/undotree",
"tpope/vim-dadbod", "kristijanhusak/vim-dadbod-ui", "kristijanhusak/vim-dadbod-completion", {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
}, {
    "preservim/nerdcommenter",
    cmd = "PlugInstall"
}, "ryanoasis/vim-devicons", "vim-airline/vim-airline", "vim-airline/vim-airline-themes",
        "editorconfig/editorconfig-vim", "gpanders/editorconfig.nvim", "vim-test/vim-test", {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast"
}, "lvimuser/lsp-inlayhints.nvim", "folke/zen-mode.nvim", {"stevearc/dressing.nvim", config = true }, "timonv/vim-cargo",
        "tpope/vim-rhubarb", "m4xshen/smartcolumn.nvim", -- use { 'mfussenegger/nvim-dap' }
'mrcjkb/rustaceanvim', {
    "neoclide/npm.nvim",
    dependencies = {"Shougo/denite.nvim"}
}, "jbyuki/instant.nvim", -- Or with configuration
{
    "projekt0n/github-nvim-theme",
    branch = "0.0.x",
    config = true
}, {
    "mg979/vim-visual-multi",
    branch = "master"
}, "Hoffs/omnisharp-extended-lsp.nvim", "puremourning/vimspector", {
    "samodostal/image.nvim",
    dependencies = {"nvim-lua/plenary.nvim", {
        "m00qek/baleia.nvim",
        version = "v1.3.0"
    }}
}, "nanotee/sqls.nvim", -- {
--     "jose-elias-alvarez/null-ls.nvim",
--     dependencies = "nvim-lua/plenary.nvim",
-- },
-- "jay-babu/mason-null-ls.nvim",
-- function(_, opts)
--     local trouble = require("trouble")
--     local symbols = trouble.statusline({
--         mode = "lsp_document_symbols",
--         groups = {},
--         title = false,
--         filter = {
--             range = true
--         },
--         format = "{kind_icon}{symbol.name:Normal}",
--         -- The following line is needed to fix the background color
--         -- Set it to the lualine section you want to use
--         hl_group = "lualine_c_normal"
--     })
--     -- table.insert(opts.sections.lualine_c, {
--     --     symbols.get,
--     --     cond = symbols.has
--     -- })
-- end
"lukas-reineke/indent-blankline.nvim", "mhinz/vim-startify", {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = true
}, {
    "kndndrj/nvim-dbee",
    dependencies = {"MunifTanjim/nui.nvim"},
    config = true
    -- }, 'mfussenegger/nvim-lint'
}}
