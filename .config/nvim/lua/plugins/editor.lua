return {{
    "kevinhwang91/nvim-ufo",
    dependencies = {"kevinhwang91/promise-async"},
    config = function()
        local ufo = require("ufo")
        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        vim.keymap.set("n", "zR", ufo.openAllFolds)
        vim.keymap.set("n", "zM", ufo.closeAllFolds)
        vim.o.foldcolumn = "1" -- '0' is not bad
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
        ufo.setup({
            provider_selector = function(bufnr, filetype, buftype)
                return {"treesitter", "indent"}
            end
        })
    end
}, {
    "luukvbaal/statuscol.nvim",
    config = function()
        local statuscol = require("statuscol")
        local builtin = require("statuscol.builtin")
        statuscol.setup({
            -- configuration goes here, for example:
            -- relculright = true,
            -- segments = {
            --     { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
            --     {
            --         sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
            --         click = "v:lua.ScSa",
            --     },
            --     { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
            --     {
            --         sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
            --         click = "v:lua.ScSa",
            --     },
            -- },
        })
    end
}, {
    "lewis6991/gitsigns.nvim",
    config = true
}, {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
}, {
    "tanvirtin/vgit.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = true
}, {
    "ruifm/gitlinker.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = true
}, {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true
}, {
    "pwntester/octo.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons"},
    config = function()
        require("octo").setup({
            suppress_missing_scope = {
                project_v2 = true
            }
        })
    end
}, {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = true
}, {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()

        local highlight = {"RainbowRed", "RainbowYellow", "RainbowBlue", "RainbowOrange", "RainbowGreen",
                           "RainbowViolet", "RainbowCyan"}

        local hooks = require "ibl.hooks"
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", {
                fg = "#E06C75"
            })
            vim.api.nvim_set_hl(0, "RainbowYellow", {
                fg = "#E5C07B"
            })
            vim.api.nvim_set_hl(0, "RainbowBlue", {
                fg = "#61AFEF"
            })
            vim.api.nvim_set_hl(0, "RainbowOrange", {
                fg = "#D19A66"
            })
            vim.api.nvim_set_hl(0, "RainbowGreen", {
                fg = "#98C379"
            })
            vim.api.nvim_set_hl(0, "RainbowViolet", {
                fg = "#C678DD"
            })
            vim.api.nvim_set_hl(0, "RainbowCyan", {
                fg = "#56B6C2"
            })
        end)
        require("ibl").setup {
            -- indent = {
            --     highlight = highlight
            -- },
            -- whitespace = {
            --     highlight = highlight,
            --     remove_blankline_trail = false
            -- },
            scope = {
                enabled = false
            }
        }
    end
}, {
    "natecraddock/workspaces.nvim",
    config = true
}}