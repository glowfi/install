-- Make Ranger replace netrw and be the file explorer
vim.cmd("let g:rnvimr_ex_enable = 1")

-- Toggle ranger
vim.cmd('nnoremap <F3> :RnvimrToggle<CR>')

-- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
vim.cmd"let g:rnvimr_enable_bw = 1"

-- Link CursorLine into RnvimrNormal highlight in the Floating window
vim.cmd"highlight link RnvimrNormal CursorLine"
