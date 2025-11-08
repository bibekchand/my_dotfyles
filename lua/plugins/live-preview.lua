return {
	"brianhuster/live-preview.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("livepreview.config").set()
		vim.keymap.set("n", "<leader>ls", ":LivePreview start<CR>", {})
		vim.keymap.set("n", "<leader>lg", ":LivePreview close<CR>", {})
	end,
}
