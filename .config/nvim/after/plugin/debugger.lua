vim.g.vimspector_enable_mappings = 'VISUAL_STUDIO'

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
