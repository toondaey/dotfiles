local telescope = require("telescope")
local trouble = require("trouble.providers.telescope")
telescope.setup({
    defaults = {
        -- file_ignore_patterns = { 'node_modules', 'target', 'obj', 'bin', '.venv', '!.vim/*' }
        -- mappings = {
        --     i = { ["<leader>y"] = trouble.open_with_trouble },
        --     n = { ["<leader>y"] = trouble.open_with_trouble },
        -- },
    },
    pickers = {
        find_files = {
            -- theme = "ivy",
            mappings = {
                n = {
                    ["cd"] = function(prompt_bufnr)
                        local selection = require("telescope.actions.state").get_selected_entry()
                        local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                        require("telescope.actions").close(prompt_bufnr)
                        -- Depending on what you want put `cd`, `lcd`, `tcd`
                        vim.cmd(string.format("silent lcd %s", dir))
                    end
                }
            }
        }
    },
    extensions = {
        file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            cwd_to_path = true,
            respect_gitignore = false
        },
        fzf = {
            case_mode = "ignore_case"
        },
        project = {
            base_dirs = {
                { "~/Work",  max_depth = 2 },
                { "~/Tunde", max_depth = 3 }
            }
        },
        frecency = {
            -- theme = 'ivy',
            ignore_patterns = { '*.git', 'node_modules', 'target', 'obj', 'bin', '.venv' }
        },
        ["ui-select"] = {
            -- require("telescope.themes").get_ivy(),
            require("telescope.themes").get_dropdown {}
        },
        workspaces = {
            -- keep insert mode after selection in the picker, default is false
            keep_insert = true,
        }
    }
})

telescope.load_extension('fzf')
telescope.load_extension("file_browser")
telescope.load_extension('project')
telescope.load_extension('ui-select')
telescope.load_extension("workspaces")

-- telescope.extensions.file_browser = finder

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function() builtin.find_files({ hidden = true, no_ignore = true }) end, { silent = true, noremap = true, desc= "Search all files in current workspace"})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { silent = true, noremap = true, desc = "Search all git branches of current workspace" })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { silent = true, noremap = true, desc = "See all git commits of current 'git' workspace"})
vim.keymap.set('n', '<leader>gf', builtin.git_files, { silent = true, noremap = true, desc = "See all git files "})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { silent = true, noremap = true, desc = "Live grep of texts in current workspace" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { silent = true, noremap = true, desc = "All buffers currently open."})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { silent = true, noremap = true, desc = "Help with all available functions and commands" })
vim.keymap.set('n', '<leader>fc', builtin.commands, { silent = true, noremap = true, desc = "See all commands" })
vim.keymap.set('n', '<leader>tb', builtin.treesitter, { silent = true, noremap = true, desc = "Open symbols available in current buffer"})
vim.keymap.set(
    "n",
    "<leader>fd",
    telescope.extensions.file_browser.file_browser,
    { noremap = true }
)
vim.keymap.set(
    "n",
    "<leader>cb",
    function() builtin.current_buffer_fuzzy_find({ skip_empty_lines = true }) end,
    { noremap = true }
)
vim.api.nvim_set_keymap(
    'n',
    '<C-p>',
    ":lua require'telescope'.extensions.project.project{}<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    "n",
    "<leader><leader>",
    function() telescope.extensions.frecency.frecency({ workspace = 'CWD' }) end,
    { noremap = true, silent = true }
)
