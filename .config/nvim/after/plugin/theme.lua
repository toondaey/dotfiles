require('catppuccin').setup({
    flavour = 'mocha',
    transparent_background = false,
    integrations = {
        barbecue = {
            dim_dirname = true,
        },
        mason = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
    }
})

require("barbecue").setup {
    theme = "github_dark_default",
}

require('github-theme').setup({
    -- ...
})

-- You NEED to enable highlight in nvim-navic setting or it won't work
require("nvim-navic").setup {
    highlight = true
}

vim.cmd.colorscheme "github_dark_default"
