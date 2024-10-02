return {{
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    config=true
},
{
    "LazyVim/LazyVim",
    opts = {
        colorscheme = "github_dark_default"
    }
}, 
{
    "SmiteshP/nvim-navic",
    config = function()
        require("nvim-navic").setup {
            highlight = true
        }
    end
}, {
    "nvim-lualine/lualine.nvim",
    dependencies = {{
        "nvim-tree/nvim-web-devicons",
        opt = true
    }},
    config = function()
        require('lualine').setup({
            options = {
                theme = 'horizon'
            }
        })
    end
}, {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {"SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons"},
    config = true
}, {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup {
            options = {
                hover = {
                    enabled = true,
                    delay = 100,
                    reveal = {'close'}
                },
                diagnostics = "nvim_lsp",
                separator_style = 'slant',
                indicator = {
                    icon = '|',
                    style = 'underline'
                }
            }
        }
        vim.opt.list = true
        vim.opt.listchars:append "space:⋅"
        vim.opt.listchars:append "eol:↴"
    end
}}
