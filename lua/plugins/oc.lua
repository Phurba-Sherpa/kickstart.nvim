return {
	"nickjvandyke/opencode.nvim",
	version = "*", -- Latest stable release
	dependencies = {
		{
			-- `snacks.nvim` integration is recommended, but optional
			---@module "snacks"
			"folke/snacks.nvim",
			optional = true,
			opts = {
				input = {}, -- Enhances `ask()`
				picker = { -- Enhances `select()`
					actions = {
						opencode_send = function(...)
							return require("opencode").snacks_picker_send(...)
						end,
					},
					win = {
						input = {
							keys = {
								["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
							},
						},
					},
				},
			},
		},
	},
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			-- Your configuration, if any
		}

		vim.o.autoread = true -- Required for `opts.events.reload`

		local opencode = require("opencode")

		-- Leader-based keymaps
		vim.keymap.set({ "n", "x" }, "<leader>oa", function()
			opencode.ask("@this: ", { submit = true })
		end, { desc = "Opencode ask" })

		vim.keymap.set({ "n", "x" }, "<leader>ox", function()
			opencode.select()
		end, { desc = "Opencode select action" })

		vim.keymap.set({ "n", "t" }, "<leader>ot", function()
			opencode.toggle()
		end, { desc = "Opencode toggle" })

		vim.keymap.set({ "n", "x" }, "<leader>or", function()
			return opencode.operator("@this ")
		end, { desc = "Opencode add range", expr = true })

		vim.keymap.set("n", "<leader>ol", function()
			return opencode.operator("@this ") .. "_"
		end, { desc = "Opencode add line", expr = true })

		vim.keymap.set("n", "<leader>ou", function()
			opencode.command("session.half.page.up")
		end, { desc = "Opencode scroll up" })

		vim.keymap.set("n", "<leader>od", function()
			opencode.command("session.half.page.down")
		end, { desc = "Opencode scroll down" })
	end,
}
