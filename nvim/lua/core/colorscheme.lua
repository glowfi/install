-- Settings
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- Line Number Highlight
vim.cmd "set cursorline"
vim.cmd "highlight clear CursorLine"
vim.cmd "highlight CursorLineNR guifg=white guibg=none ctermbg=none ctermfg=none"
