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
}, {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {{
        'tpope/vim-dadbod',
        lazy = true
    }, {
        'kristijanhusak/vim-dadbod-completion',
        ft = {'sql', 'mysql', 'plsql'},
        lazy = true
    } -- Optional
    },
    cmd = {'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer'},
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
    end
}, "ryanoasis/vim-devicons", "editorconfig/editorconfig-vim",{
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup()
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
},
 "tpope/vim-rhubarb",{
  "m4xshen/smartcolumn.nvim",
  opts = {}
},
-- "jbyuki/instant.nvim", -- Or with configuration
{
    "mg979/vim-visual-multi",
    branch = "master"
}, {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
},
-- 'mfussenegger/nvim-lint',
        {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false
}, {
    "folke/flash.nvim",
    enabled = false
}}
