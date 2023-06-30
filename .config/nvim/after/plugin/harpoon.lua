local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>A", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

 vim.keymap.set("n", "<C-,>", function() ui.nav_prev() end)
 vim.keymap.set("n", "<C-.>", function() ui.nav_next() end)
