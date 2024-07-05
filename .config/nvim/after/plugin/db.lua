local dbee = require('dbee')

vim.keymap.set("n", "<leader>db", function() dbee.toggle() end)

