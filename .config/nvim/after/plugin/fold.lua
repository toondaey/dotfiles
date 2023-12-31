local ufo = require("ufo")
local statuscol = require("statuscol")
local builtin = require("statuscol.builtin")
local gitsigns = require("gitsigns")

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)

gitsigns.setup()
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
ufo.setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
})
