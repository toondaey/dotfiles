-- Remaps for the refactoring operations currently offered by the plugin
vim.keymap.set("v", "<leader>re", function () require('refactoring').refactor('Extract Function') end, {noremap = true, silent = true, expr = false})
vim.keymap.set("v", "<leader>rf", function () require('refactoring').refactor('Extract Function To File') end, {noremap = true, silent = true, expr = false})
vim.keymap.set("v", "<leader>rv", function () require('refactoring').refactor('Extract Variable') end, {noremap = true, silent = true, expr = false})
vim.keymap.set("v", "<leader>ri", function () require('refactoring').refactor('Inline Variable') end, {noremap = true, silent = true, expr = false})

-- Extract block doesn't need visual mode
vim.keymap.set("n", "<leader>rb", function () require('refactoring').refactor('Extract Block') end, {noremap = true, silent = true, expr = false})
vim.keymap.set("n", "<leader>rbf", function () require('refactoring').refactor('Extract Block To File') end, {noremap = true, silent = true, expr = false})

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.keymap.set("n", "<leader>ri", function () require('refactoring').refactor('Inline Variable') end, {noremap = true, silent = true, expr = false})

vim.keymap.set("n", "<leader>tt", vim.cmd.TestNearest, {silent = true})
vim.keymap.set("n", "<leader>T", vim.cmd.TestFile, {silent = true})
vim.keymap.set("n", "<leader>a", vim.cmd.TestSuite, {silent = true})
vim.keymap.set("n", "<leader>l", vim.cmd.TestLast, {silent = true})
vim.keymap.set("n", "<leader>g", vim.cmd.TestVisit, {silent = true})


vim.keymap.set("n", "<F5>", [[:call vimspector#Continue()<CR>]], {silent = false})
vim.keymap.set("i", "<F5>", [[<Esc>:call vimspector#Continue()<CR>==gi]], {silent = false})

vim.keymap.set("n", "<F17>", [[:call vimspector#Reset()<CR>]], {silent = false})
vim.keymap.set("i", "<F17>", [[<Esc>:call vimspector#Reset()<CR>==gi]], {silent = false})

vim.keymap.set("n", "<leader><F29>", [[:call vimspector#Restart()<CR>]], {silent = false})
vim.keymap.set("i", "<leader><F29>", [[<Esc>:call vimspector#Restart()<CR>==gi]], {silent = false})

vim.keymap.set("n", "<F6>", [[:call vimspector#Pause()<CR>]], {silent = false})
vim.keymap.set("i", "<F6>", [[<Esc>:call vimspector#Pause()<CR>==gi]], {silent = false})

vim.keymap.set("n", "<F8>", [[:call vimspector#JumpToNextBreakpoint()<CR>]], {silent = false})
vim.keymap.set("i", "<F8>", [[<Esc>:call vimspector#JumpToNextBreakpoint()<CR>==gi]], {silent = false})

vim.keymap.set("n", "<F19>", [[:call vimspector#JumpToPreviousBreakpoint()<CR>]], {silent = false})
vim.keymap.set("i", "<F19>", [[<Esc>:call vimspector#JumpToPreviousBreakpoint()<CR>==gi]], {silent = false})

vim.keymap.set("n", "<F9>", [[:call vimspector#ToggleBreakpoint()<CR>]], {silent = false})
vim.keymap.set("i", "<F9>", [[<Esc>:call vimspector#ToggleBreakpoint()<CR>==gi]], {silent = false})

vim.keymap.set("n", "<F21>", [[:call vimspector#AddFunctionBreakpoint()<CR>]], {silent = false})
vim.keymap.set("i", "<F21>", [[<Esc>:call vimspector#AddFunctionBreakpoint()<CR>==gi]], {silent = false})

vim.keymap.set("n", "<F10>", [[:call vimspector#StepOver()<CR>]], {silent = false})
vim.keymap.set("i", "<F10>", [[<Esc>:call vimspector#StepOver()<CR>==gi]], {silent = false})

vim.keymap.set("n", "<F11>", [[:call vimspector#StepInto()<CR>]], {silent = false})
vim.keymap.set("i", "<F11>", [[<Esc>:call vimspector#StepInto()<CR>==gi]], {silent = false})

vim.keymap.set("n", "<F23>", [[:call vimspector#StepOut()<CR>]], {silent = false})
vim.keymap.set("i", "<F23>", [[<Esc>:call vimspector#StepOut()<CR>==gi]], {silent = false})

vim.keymap.set("n", "<•>", [[:call vimspector#Disassemble()<CR>]], {silent = false})
vim.keymap.set("i", "<•>", [[<Esc>:call vimspector#Disassemble()<CR>==gi]], {silent = false})


vim.keymap.set("n", "<leader>di", vim.cmd.VimspectorBalloonEval, {silent = false})
vim.keymap.set("x", "<leader>di", vim.cmd.VimspectorBalloonEval, {silent = false})

