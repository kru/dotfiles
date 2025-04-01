-- LSP Stuff
vim.lsp.config.clangd = {
		cmd = { "clangd", "--background-index" },
		filetypes = { "c", "h" },
}

vim.lsp.config.luals = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			completion = { callSnippet = "Replace" },
			-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			diagnostics = {
				disable = { 'missing-fields' },
				globals = { "vim" }
			},
		}
	}
}

vim.lsp.config.ols = {
	cmd = { "ols" },
	root_dir = vim.fs.dirname(vim.fs.find({ 'ols.json' }, { upward = true })[1]),
	filetypes = { "odin" },
}

vim.lsp.config.gopls = {
	cmd = { "gopls" },
	filetypes = { "go" },
	settings = {
		completeUnimported = true,
		usePlaceholders = true,
		gofumpt = true,
		staticcheck = true,
		analyses = {
			unusedparams = true,
		},
	},
}

vim.lsp.enable("clangd")
vim.lsp.enable("luals")
vim.lsp.enable("ols")
vim.lsp.enable("gopls")

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- local bufopts = { noremap = true, silent = true, buffer = bufnr }
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "[G]oto Definition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto References")
	nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto Implementation")
	nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument Symbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace Symbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<leader>sh", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace List Folders")

	vim.keymap.set("n", "<leader>fm", function()
		vim.lsp.buf.format()
	end, { buffer = bufnr, desc = "format current file" })
end

-- auto completion
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
		end
		on_attach(client, vim.api.nvim_get_current_buf())
	end,
})

vim.lsp.buf.hover()
