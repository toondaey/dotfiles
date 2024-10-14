return {
    {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {'nvim-lua/plenary.nvim', "folke/trouble.nvim", {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = 'make'
    }, "nvim-telescope/telescope-file-browser.nvim", "nvim-telescope/telescope-project.nvim",
                    "nvim-telescope/telescope-frecency.nvim", "nvim-telescope/telescope-ui-select.nvim",
                    "nvim-telescope/telescope-media-files.nvim"},
    opts = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local trouble_source = require("trouble.sources.telescope")
        local fb_utils = require("telescope._extensions.file_browser.utils")
        local action_state = require("telescope.actions.state")

        local live_grep_dir = function(prompt_bufnr)
            local search_dirs = fb_utils.get_selected_files(prompt_bufnr, false)
            local entry = action_state.get_selected_entry()
            if not vim.tbl_isempty(search_dirs) then
                local i = 1
                while i <= #search_dirs do
                    if search_dirs[i] ~= nil then
                        search_dirs[i] = tostring(search_dirs[i])
                    end
                    i = i + 1
                end
                builtin.live_grep({
                    search_dirs = search_dirs
                })
            elseif not vim.tbl_isempty(entry) and entry[1] ~= nil then
                builtin.live_grep({
                    search_dirs = {entry[1]}
                })
            else
                fb_utils.notify("action.rename", {
                    msg = "No path(s) to search!",
                    level = "WARN"
                })
            end
        end
        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<c-t>"] = trouble_source.open
                    },
                    n = {
                        ["<c-t>"] = trouble_source.open
                    }
                }
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
                    grouped = true,
                    hijack_netrw = true,
                    cwd_to_path = true,
                    respect_gitignore = false,
                    mappings = {
                        ["i"] = {
                            ["<A-z>"] = live_grep_dir
                        },
                        ["n"] = {
                            ["z"] = live_grep_dir
                        }
                    }
                },
                fzf = {
                    case_mode = "ignore_case"
                },
                project = {
                    base_dirs = {{
                        "~/Work",
                        max_depth = 2
                    }, {
                        "~/Tunde",
                        max_depth = 1
                    }},
                    hidden_files = true
                },
                frecency = {
                    -- theme = 'ivy',
                    ignore_patterns = {"*.git", "node_modules", "target", "obj", "bin", ".venv"}
                },
                ["ui-select"] = {require("telescope.themes").get_dropdown({})},
                -- workspaces = {
                --     -- keep insert mode after selection in the picker, default is false
                --     keep_insert = true
                -- }
            }
        })

        telescope.load_extension("fzf")
        telescope.load_extension("file_browser")
        telescope.load_extension("project")
        telescope.load_extension("ui-select")
        -- telescope.load_extension("workspaces")
        telescope.load_extension("media_files")

        -- local trouble = require("trouble")
        -- vim.keymap.set("n", "<leader>xx", "<cmd>Trouble split_right toggle focus=true<cr>", {
        --     silent = true,
        --     noremap = true,
        --     desc = "Toggle trouble."
        -- })
        -- vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle focus=true<cr>", {
        --     silent = true,
        --     noremap = true,
        --     desc = "Toggle trouble workspace diagnostics."
        -- })
        -- vim.keymap.set("n", "<leader>xX", "<cmd>Trouble preview_float toggle focus=true filter.buf=0<cr>", {
        --     silent = true,
        --     noremap = true,
        --     desc = "Toggle trouble for current buffer."
        -- })
        -- vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", {
        --     silent = true,
        --     noremap = true,
        --     desc = "Toggle trouble loclist"
        -- })
        -- vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", {
        --     silent = true,
        --     noremap = true,
        --     desc = "Toggle trouble with a quick fix"
        -- })
        -- vim.keymap.set("n", "<leader>xL", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>")
        -- vim.keymap.set("n", "<leader>cS", "<cmd>Trouble symbols toggle focus=false<cr>")

        -- trouble.setup({
        --     modes = {
        --         preview_float = {
        --             mode = "diagnostics",
        --             preview = {
        --                 type = "float",
        --                 relative = "editor",
        --                 border = "rounded",
        --                 title = "Preview",
        --                 title_pos = "center",
        --                 position = {0, -2},
        --                 size = {
        --                     width = 0.45,
        --                     height = 0.45
        --                 },
        --                 zindex = 200
        --             }
        --         },
        --         split_right = {
        --             mode = "diagnostics",
        --             preview = {
        --                 type = "split",
        --                 relative = "win",
        --                 position = "right",
        --                 size = 0.3
        --             }
        --         }
        --     }
        -- })

        -- telescope.extensions.file_browser = finder

        vim.keymap.set("n", "<leader>ff", function()
            builtin.find_files({
                hidden = true,
                no_ignore = true
            })
        end, {
            silent = true,
            noremap = true,
            desc = "Search all files in current workspace"
        })
        -- vim.keymap.set("n", "<leader>gb", builtin.git_branches, {
        --     silent = true,
        --     noremap = true,
        --     desc = "Search all git branches of current workspace"
        -- })
        -- vim.keymap.set("n", "<leader>gc", builtin.git_commits, {
        --     silent = true,
        --     noremap = true,
        --     desc = "See all git commits of current 'git' workspace"
        -- })
        -- vim.keymap.set("n", "<leader>gf", builtin.git_files, {
        --     silent = true,
        --     noremap = true,
        --     desc = "See all git files "
        -- })
        vim.keymap.set("n", "<leader>/", builtin.live_grep, {
            silent = true,
            noremap = true,
            desc = "Live grep of texts in current workspace"
        })
        -- vim.keymap.set("n", "<leader>fb", builtin.buffers, {
        --     silent = true,
        --     noremap = true,
        --     desc = "All buffers currently open."
        -- })
        -- vim.keymap.set("n", "<leader>fh", builtin.help_tags, {
        --     silent = true,
        --     noremap = true,
        --     desc = "Help with all available functions and commands"
        -- })
        -- vim.keymap.set("n", "<leader>fc", builtin.commands, {
        --     silent = true,
        --     noremap = true,
        --     desc = "See all commands"
        -- })
        vim.keymap.set("n", "<leader>tb", builtin.treesitter, {
            silent = true,
            noremap = true,
            desc = "Open symbols available in current buffer"
        })
        vim.keymap.set("n", "<leader>fd", telescope.extensions.file_browser.file_browser, {
            noremap = true,
            silent = true,
            desc = "Open file browser"
        })
        vim.keymap.set("n", "<leader>cb", function()
            builtin.current_buffer_fuzzy_find({
                skip_empty_lines = true
            })
        end, {
            noremap = true,
            silent = true,
            desc = "Fuzzy finder in current buffer"
        })
        vim.keymap.set("n", "<leader>fp", function()
            telescope.extensions.project.project()
        end, {
            noremap = true,
            silent = true,
            desc = "Change project"
        })
        -- vim.keymap.set("n", "<leader><leader>", function()
        --     telescope.extensions.frecency.frecency({
        --         workspace = "CWD"
        --     })
        -- end, {
        --     noremap = true,
        --     silent = true,
        --     desc = "Frecency"
        -- })
        vim.keymap.set("n", "<leader>cg", function()
            telescope.extensions.file_browser.file_browser({
                path = "%:p:h",
                select_buffer = true
            })
        end, {
            noremap = true,
            silent = true,
            desc = "Open file_browser with the path of the current buffer"
        })
    end
}
}
