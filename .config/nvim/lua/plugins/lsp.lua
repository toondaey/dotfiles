return {{
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false
}, {
    'williamboman/mason.nvim',
    lazy = false,
    config = true
}, -- Autocompletion
{
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {{
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    }},
    config = function()
        local cmp = require('cmp')
        cmp.setup({
            sources = {{
                name = 'nvim_lsp'
            }},
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4)
            }),
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end
            }
        })
    end
}, -- LSP
{
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {{'hrsh7th/cmp-nvim-lsp'}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-path"},
                    {'saadparwaiz1/cmp_luasnip'}, {'hrsh7th/cmp-nvim-lua'}, {'L3MON4D3/LuaSnip'},
                    {'rafamadriz/friendly-snippets'}, {'williamboman/mason.nvim'}, {"nanotee/sqls.nvim"},
                    {'williamboman/mason-lspconfig.nvim'}, {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false -- This plugin is already lazy
    }, {"Hoffs/omnisharp-extended-lsp.nvim"}, {"lvimuser/lsp-inlayhints.nvim"}},
    config = function()
        local lsp_zero = require('lsp-zero')
        -- lsp_attach is where you enable features that only work
        -- if there is a language server active in the file
        local lsp_attach = function(client, bufnr)
            local opts = {
                buffer = bufnr
            }
            vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
            vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
            vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
            vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
            vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end
        lsp_zero.extend_lspconfig({
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            lsp_attach = lsp_attach,
            -- float_border = 'rounded', -- Disabled because it interfares with noice
            sign_text = true
        })
        require('mason-lspconfig').setup({
            -- lsp_zero.default_setup,
            ensure_installed = {"lua_ls", "ts_ls", "eslint", "pyright", "omnisharp"},
            handlers = { -- this first function is the "default handler"
                -- it applies to every language server without a "custom handler"
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        on_init = function(client)
                            lsp_zero.nvim_lua_settings(client, {})
                        end
                    })
                end,
                pyright = function()
                    require('lspconfig').pyright.setup({
                        on_attach = function(client, bufnr)
                            local util = require("lspconfig/util")
                            local path = util.path
                            -- From: https://github.com/IceS2/dotfiles/blob/master/nvim/lua/plugins_cfg/mason_ls_and_dap.lua
                            local function get_python_path(workspace)
                                -- Use activated virtualenv.
                                if vim.env.VIRTUAL_ENV or vim.fn.glob(path.join(workspace, ".venv")) then
                                    local venv_path = vim.env.VIRTUAL_ENV or vim.fn.glob(path.join(workspace, ".venv"))
                                    return path.join(venv_path, "bin", "python")
                                end
                                -- Find and use virtualenv in workspace directory.
                                for _, pattern in ipairs({"*", ".*"}) do
                                    local match = vim.fn.glob(path.join(workspace, pattern, ".python-local"))
                                    if match ~= "" then
                                        return path.join(vim.env.PYENV_ROOT, "versions", path.dirname(match), "bin",
                                            "python")
                                    end
                                end
                                -- Fallback to system Python.
                                return exepath("python3") or exepath("python") or "python"
                            end
                            -- local function get_venv(workspace)
                            --     for _, pattern in ipairs({"*", ".*"}) do
                            --         local match = vim.fn.glob(path.join(workspace, pattern, ".python-local"))
                            --         if match ~= "" then
                            --             return match
                            --         end
                            --     end
                            -- end
                            client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
                        end,
                        settings = {
                            python = {
                                venvPath = ".venv",
                                venv = ".",
                                disableLanguageServices = true,
                                disableOrganizeImports = true,
                                analysis = {
                                    diagnosticMode = "workspace",
                                    typeCheckingMode = "off",
                                    logLevel = "Information",
                                    autoSearchPaths = true
                                }
                            }
                        }
                    })
                end,
                omnisharp = function()
                    require('lspconfig').omnisharp.setup({
                        on_attach = function(client, buffer)
                            client.server_capabilities.semanticTokensProvider.legend = {
                                tokenModifiers = {"static"},
                                tokenTypes = {"comment", "excluded", "identifier", "keyword", "number", "operator",
                                              "preprocessor", "string", "whitespace", "text", "static", "punctuation",
                                              "string", "class", "delegate", "enum", "interface", "module", "struct",
                                              "typeParameter", "field", "enumMember", "constant", "local", "parameter",
                                              "method", "property", "event", "namespace", "label", "xml", "regexp"}
                            }
                        end,
                        handlers = {
                            ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
                            ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
                            ["textDocument/references"] = require('omnisharp_extended').references_handler,
                            ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler
                        },
                        organize_imports_on_format = true
                    })
                end,
                sqls = function(client, bufnr)
                    require('lspconfig').sqls.setup {
                        on_attach = function(client, bufnr)
                            require('sqls').on_attach(client, bufnr)
                        end
                    }
                end,
                rust_analyzer = lsp_zero.noop
            }
        })
        vim.g.rustaceanvim = {
            server = {
                default_settings = lsp_zero.get_capabilities()
            }
        }
        local cmp = require('cmp')
        local cmp_action = lsp_zero.cmp_action()
        local cmp_format = lsp_zero.cmp_format()
        require('luasnip.loaders.from_vscode').lazy_load()
        vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
        cmp.setup({
            sources = {{
                name = 'path'
            }, {
                name = 'nvim_lsp'
            }, {
                name = 'nvim_lua'
            }, {
                name = 'buffer',
                keyword_length = 3
            }, {
                name = 'luasnip',
                keyword_length = 2
            }},
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                -- confirm completion item
                ['<CR>'] = cmp.mapping.confirm({
                    select = false
                }),
                -- toggle completion menu
                ['<C-e>'] = cmp_action.toggle_completion(),
                -- tab complete
                ['<Tab>'] = cmp_action.tab_complete(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                -- navigate between snippet placeholder
                ['<C-d>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                -- scroll documentation window
                ['<C-f>'] = cmp.mapping.scroll_docs(-5),
                ['<C-u>'] = cmp.mapping.scroll_docs(5)
            }),
            window = {
                documentation = cmp.config.window.bordered()
            },
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            formatting = cmp_format
        })
        -- Restart LSP server
        vim.keymap.set("n", "<leader>lrs", vim.cmd.LspRestart, {
            silent = false
        })
    end
} -- {
--     "hrsh7th/nvim-cmp",
--     dependencies = {"hrsh7th/cmp-emoji"},
--     ---@param opts cmp.ConfigSchema
--     opts = function(_, opts)
--         table.insert(opts.sources, {
--             name = "emoji"
--         })
--         local has_words_before = function()
--             unpack = unpack or table.unpack
--             local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--             return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--         end
--         local cmp = require("cmp")
--         opts.mapping = vim.tbl_extend("force", opts.mapping, {
--             ["<Tab>"] = cmp.mapping(function(fallback)
--                 if cmp.visible() then
--                     -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
--                     cmp.select_next_item()
--                 elseif vim.snippet.active({
--                     direction = 1
--                 }) then
--                     vim.schedule(function()
--                         vim.snippet.jump(1)
--                     end)
--                 elseif has_words_before() then
--                     cmp.complete()
--                 else
--                     fallback()
--                 end
--             end, {"i", "s"}),
--             ["<S-Tab>"] = cmp.mapping(function(fallback)
--                 if cmp.visible() then
--                     cmp.select_prev_item()
--                 elseif vim.snippet.active({
--                     direction = -1
--                 }) then
--                     vim.schedule(function()
--                         vim.snippet.jump(-1)
--                     end)
--                 else
--                     fallback()
--                 end
--             end, {"i", "s"})
--         })
--     end
-- }
}
