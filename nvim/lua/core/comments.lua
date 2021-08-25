-- Keymappings
require('nvim_comment').setup({comment_empty = false})
vim.api.nvim_set_keymap('n', '<C-_>', ":CommentToggle<CR>", {noremap = true, silent = true})
