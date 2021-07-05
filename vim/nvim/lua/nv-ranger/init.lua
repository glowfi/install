-- Make Ranger replace netrw and be the file explorer
vim.cmd("let g:rnvimr_ex_enable = 1")

-- Toggle ranger
vim.cmd('nnoremap <F3> :RnvimrToggle<CR>')
