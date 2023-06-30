vim.keymap.set("n", "<leader>pv", vim.cmd.Ex);

-- move current line (in visual, normal and insert mode) up and down
vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv", {silent = true})
vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv", {silent = true})
vim.keymap.set("n", "∆", ":m .+1<CR>==", {silent = true})
vim.keymap.set("n", "˚", ":m .-2<CR>==", {silent = true})
vim.keymap.set("i", "∆", "<Esc>:m .+1<CR>==gi", {silent = true})
vim.keymap.set("i", "˚", "<Esc>:m .-2<CR>==gi", {silent = true})

-- Jump pages without the cursor leaving the middle of the buffer
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Allow copying of and pasting without loosing copied item
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Allow copying from vim clipboard to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Supposedly enable switching of projects
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Format current buffer
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Diagnoses i.e. go to next/previous error.
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- highlight current word on which the cursor is and set it up for replacement
vim.keymap.set("n", "<leader>d", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- automatically chmod +x a file you're in
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Save file
vim.keymap.set("n", "<C-s>", [[:w<CR>]], {silent = true})
vim.keymap.set("i", "<C-s>", [[<Esc>:w<CR>==gi]], {silent = true, noremap = true})
vim.keymap.set("v", "<C-s>", [[<Esc>:w<CR>gv=gv]], {silent = true, noremap = true})
-- Save all files
vim.keymap.set("n", "<C-A-s>", [[:wa<CR>]], {silent = true})
vim.keymap.set("i", "<C-A-s>", [[<Esc>:wa<CR>==gi]], {silent = true, noremap = true})
vim.keymap.set("v", "<C-A-s>", [[<Esc>:wa<CR>gv=gv]])

-- close current buffer without deleting
vim.keymap.set("n", "<C-x>", ":bw<CR>", {silent = true})

-- Bring next line to current line without cursor jumping all the way to the back
vim.keymap.set("n", "J", "mzJ`z", {silent = true})

vim.keymap.set("n", "<leader>.", [[<C-W>>]])
vim.keymap.set("n", "<leader>,", [[<C-W><]])
vim.keymap.set("n", "<leader>-", [[<C-W>-]])
vim.keymap.set("n", "<leader>=", [[<C-W>+]])
