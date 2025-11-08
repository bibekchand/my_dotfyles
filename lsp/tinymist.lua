return {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {
        formatterMode = "typstyle",
    }
}
