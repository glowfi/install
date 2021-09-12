-- Settings
require("nnn").setup({
	command = "nnn -d -e",
	session = "local",
	set_default_mappings = 0,
	replace_netrw = 1,
})

-- Keymappings
vim.cmd "nnoremap <silent> <leader>nn :NnnPicker<CR>"
