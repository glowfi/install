-- Default settings
local saga = require 'lspsaga'
saga.init_lsp_saga()

-- Code actions
vim.cmd("nnoremap <silent><leader>ca :Lspsaga code_action<CR>")
vim.cmd("vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>")

-- Hoover Doc
vim.cmd("nnoremap <silent>K :Lspsaga hover_doc<CR>")
-- Scroll down hover doc
vim.cmd("nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
-- Scroll up hover doc
vim.cmd("nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")

-- Signature Help
vim.cmd("nnoremap <silent> gs :Lspsaga signature_help<CR>")

-- Rename
vim.cmd("nnoremap <silent>gr :Lspsaga rename<CR>")

-- Jump Diagnostics
vim.cmd("nnoremap <silent> <c-[> :Lspsaga diagnostic_jump_next<CR>")
vim.cmd("nnoremap <silent> <c=]> :Lspsaga diagnostic_jump_prev<CR>")

-- Float terminal
vim.cmd("nnoremap <silent> <s-s> :Lspsaga open_floaterm<CR>")
vim.cmd("tnoremap <silent> <s-h> <C-\\><C-n>:Lspsaga close_floaterm<CR>")
