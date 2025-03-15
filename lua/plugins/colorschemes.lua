-- return {
-- 	"projekt0n/github-nvim-theme",
-- 	name = "github-theme",
-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
-- 	priority = 1000, -- make sure to load this before all the other start plugins
-- 	config = function()
-- 		require("github-theme").setup({})
--
-- 		vim.cmd("colorscheme github_dark_default")
-- 		vim.cmd.hi("Comment gui=none")
-- 		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#6e7681" })
-- 		vim.api.nvim_set_hl(0, "LineNr", { fg = "white" })
-- 		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#6e7681" })
-- 	end,
-- }

return {
	"folke/tokyonight.nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		vim.cmd.colorscheme("tokyonight-night")
		vim.cmd.hi("Comment gui=none")
		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#6e7681" })
		vim.api.nvim_set_hl(0, "LineNr", { fg = "white" })
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#6e7681" })
	end,
	opts = {
		transparent = false,
	},
}
-- Install without configuration
