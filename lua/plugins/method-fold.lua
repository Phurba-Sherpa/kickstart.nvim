return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		-- Basic folding settings
		vim.o.foldcolumn = "1" -- Show fold column with minimal width
		vim.o.foldlevel = 99 -- Required high value for ufo
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		-- Key mappings for folding
		vim.keymap.set("n", "zR", require("ufo").openAllFolds)
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

		-- Option 2: Set up with nvim-lsp as the LSP client
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		local language_servers = require("lspconfig").util.available_servers()
		for _, ls in ipairs(language_servers) do
			require("lspconfig")[ls].setup({
				capabilities = capabilities,
				-- Additional LSP setup options can go here
			})
		end

		require("ufo").setup()
	end,
}
