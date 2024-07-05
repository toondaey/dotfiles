-- Learn the keybindings, see :help lsp-zero-
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require("lsp-zero")
local ih = require("lsp-inlayhints")
local rt = require("rust-tools")
lsp.preset("recommended")

ih.setup()

lsp.ensure_installed({
	"tsserver",
	"rust_analyzer",
	"eslint",
	"pyright",
	"omnisharp",
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.set_preferences({
	suggest_lsp_servers = true,
	sign_icons = {
		error = "🚫",
		warn = "⚠️",
		hint = "💡",
		info = "ℹ️",
	},
})

lsp.on_attach(function(client, bufnr)
	ih.on_attach(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.configure("lua_ls", {
	on_attach = function(c, b)
		ih.on_attach(c, b)
	end,
	Lua = {
		diagnostics = {
			globals = { "vim" },
		},
	},
})

lsp.configure("sqlls", {
	on_attach = function(c, b)
		require("sqlls").on_attach(c, b)
	end,
})

lsp.configure("yamlls", {
	settings = {
		yaml = {
			keyOrdering = false,
			schemas = {
				["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/github-workflow.json"] = "./.github/workflow/*.ya?ml",
			},
		},
	},
})

lsp.configure("tsserver", {
	on_attach = function(c, b)
		ih.on_attach(c, b)
	end,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
	},
})

lsp.configure("omnisharp", {
	on_attach = function(client, buffer)
		client.server_capabilities.semanticTokensProvider.legend = {
			tokenModifiers = { "static" },
			tokenTypes = {
				"comment",
				"excluded",
				"identifier",
				"keyword",
				"number",
				"operator",
				"preprocessor",
				"string",
				"whitespace",
				"text",
				"static",
				"punctuation",
				"string",
				"class",
				"delegate",
				"enum",
				"interface",
				"module",
				"struct",
				"typeParameter",
				"field",
				"enumMember",
				"constant",
				"local",
				"parameter",
				"method",
				"property",
				"event",
				"namespace",
				"label",
				"xml",
				"regexp",
			},
		}
		ih.on_attach(client, buffer)
	end,
	handlers = {
		["textDocument/definition"] = require("omnisharp_extended").handler,
		-- ["textDocument/inlahHint"] = function (client)
		--     local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

		--     local handler = function(err, result, ctx, config)
		--       ctx.params = params
		--       print(ctx)
		--     end
		--     client.request('textDocument/inlahHint', params, handler)
		-- end
	},
	organize_imports_on_format = true,
	-- csharp = {
	--     inlayHints = {parameters = {enabled = true }}
	-- }
})

rt.setup({
	tools = {
		inlay_hints = {
			auto = true,
			only_current_line = true,
		},
	},
})

lsp.configure("pyright", {
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
			for _, pattern in ipairs({ "*", ".*" }) do
				local match = vim.fn.glob(path.join(workspace, pattern, ".python-local"))
				if match ~= "" then
					return path.join(vim.env.PYENV_ROOT, "versions", path.dirname(match), "bin", "python")
				end
			end

			-- Fallback to system Python.
			return exepath("python3") or exepath("python") or "python"
		end

		local function get_venv(workspace)
			for _, pattern in ipairs({ "*", ".*" }) do
				local match = vim.fn.glob(path.join(workspace, pattern, ".python-local"))
				if match ~= "" then
					return match
				end
			end
		end

		client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
		-- client.config.settings.venvPath = path.join(vim.env.PYENV_ROOT, "versions")
		-- print(client.config.settings.venvPath)
		-- client.config.settings.venv = get_venv(client.config.root_dir)
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
				autoSearchPaths = true,
			},
		},
	},
})

vim.lsp.set_log_level("info")
-- lsp.format_mapping("gq", {
--     format_opts = {
--         async = false,
--         timeout_ms = 10000,
--     },
--     servers = {
--         ["null-ls"] = { "javascript", "typescript", "lua", "python", "csharp", "go" },
--     },
-- })

lsp.setup()

local trouble = require("trouble")

trouble.setup()
-- Lua
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true, desc = "Toggle trouble." })
vim.keymap.set(
	"n",
	"<leader>xw",
	"<cmd>TroubleToggle workspace_diagnostics<cr>",
	{ silent = true, noremap = true, desc = "Toggle trouble workspace diagnostics." }
)
vim.keymap.set(
	"n",
	"<leader>xd",
	"<cmd>TroubleToggle document_diagnostics<cr>",
	{ silent = true, noremap = true, desc = "Toggle trouble for current buffer." }
)
vim.keymap.set(
	"n",
	"<leader>xl",
	"<cmd>TroubleToggle loclist<cr>",
	{ silent = true, noremap = true, desc = "Toggle trouble loclist" }
)
vim.keymap.set(
	"n",
	"<leader>xq",
	"<cmd>TroubleToggle quickfix<cr>",
	{ silent = true, noremap = true, desc = "Toggle trouble with a quick fix" }
)
vim.keymap.set(
	"n",
	"gR",
	"<cmd>TroubleToggle lsp_references<cr>",
	{ silent = true, noremap = true, desc = "Toggle trouble with lsp_references" }
)

vim.diagnostic.config({
	virtual_text = true,
})

-- Restart LSP server
vim.keymap.set("n", "<leader>lrs", vim.cmd.LspRestart, { silent = false })
