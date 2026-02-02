return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		formatters_by_ft = {
			-- lua = { "stylua" },
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
			-- typescript = { "prettierd", "prettier", stop_after_first = true },
			-- javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			-- typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			-- html = { "prettierd", stop_after_first = true },
			-- css = { "prettierd", stop_after_first = true },
			-- python = function(bufnr)
			-- 	local bufname = vim.api.nvim_buf_get_name(bufnr)
			-- 	if bufname:match("/sentinel/backend/") then
			-- 		return {}
			-- 	end
			-- 	return { "black", "isort" }
			-- end,
			lua = { "stylua" },

			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },

			javascriptreact = function(bufnr)
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("/sentinel/frontend/") then
					return {} -- disable formatting
				end
				return { "prettierd", "prettier", stop_after_first = true }
			end,

			typescriptreact = function(bufnr)
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("/sentinel/frontend/") then
					return {} -- disable formatting
				end
				return { "prettierd", "prettier", stop_after_first = true }
			end,

			html = { "prettierd", stop_after_first = true },
			css = { "prettierd", stop_after_first = true },

			python = function(bufnr)
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("/sentinel/backend/") then
					return {}
				end
				return { "black", "isort" }
			end,
		},
	},
}
