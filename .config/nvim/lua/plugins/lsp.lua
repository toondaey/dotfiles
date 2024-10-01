return {{
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    dependencies = { -- LSP Support
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    }, {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason").setup()
        end
    }, {
        "neovim/nvim-lspconfig",
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {'hrsh7th/cmp-nvim-lsp', "qnighy/lalrpop.vim", "Decodetalkers/csharpls-extended-lsp.nvim"}
    }, -- Autocompletion
    "hrsh7th/nvim-cmp", -- Required
    "hrsh7th/cmp-nvim-lsp", -- Required
    "hrsh7th/cmp-buffer", -- Optional
    "hrsh7th/cmp-path", -- Optional
    "saadparwaiz1/cmp_luasnip", -- Optional
    "hrsh7th/cmp-nvim-lua", -- Optional
    -- Snippets
    "L3MON4D3/LuaSnip", -- Required
    "rafamadriz/friendly-snippets"},
    config = function()
        local lspzero = require('lsp-zero')
        local lspconfig = require("lspconfig")

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

        lspzero.extend_lspconfig({
            sign_text = true,
            lsp_attach = lsp_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities()
        })

        require('mason-lspconfig').setup({
            -- lspzero.default_setup,
            ensure_installed = {"lua_ls", "ts_ls", "eslint", "pyright", "omnisharp"},
            handlers = { -- this first function is the "default handler"
            -- it applies to every language server without a "custom handler"
            function(server_name)
                lspconfig[server_name].setup({})
            end},
            lua_ls = function()
                lspconfig.lua_ls.setup({
                    on_init = function(client)
                        lspzero.nvim_lua_settings(client, {})
                    end
                })
            end,
            pyright = function()
                lspconfig.pyright.setup({
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

                        local function get_venv(workspace)
                            for _, pattern in ipairs({"*", ".*"}) do
                                local match = vim.fn.glob(path.join(workspace, pattern, ".python-local"))
                                if match ~= "" then
                                    return match
                                end
                            end
                        end

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
                lspconfig.omnisharp.setup({
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
            rust_analyzer = lspzero.noop
        })
    end
}}
