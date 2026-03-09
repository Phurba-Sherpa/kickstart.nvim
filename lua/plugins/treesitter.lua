return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local filetypes = {
			"bash",
			"c",
			"typescript",
			"javascript",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"css",
			"tsx",
			"go",
			"json",
		}

		-- Install parsers asynchronously to avoid blocking messages
		vim.schedule(function()
			require("nvim-treesitter").install(filetypes)
		end)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
