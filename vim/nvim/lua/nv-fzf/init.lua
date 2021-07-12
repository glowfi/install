-- Key Mappings
vim.api.nvim_set_keymap('n', '<s-F>', ':Files<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<s-c>', ':Rg<CR>', {noremap = true, silent = true})

--fzf-vim
vim.cmd("let g:fzf_action = { 'ctrl-t': 'tab split','ctrl-s': 'split','s-v': 'vsplit' }")

-- fzf theme
vim.cmd("let g:fzf_colors ={ 'fg': ['fg', 'Normal'],  'bg':      ['bg', 'Normal'],  'hl':      ['fg', 'Comment'],  'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],  'bg+':     ['bg', 'CursorLine', 'CursorColumn'],  'hl+':     ['fg', 'Statement'],  'info':    ['fg', 'Type'],  'border':  ['fg', 'Constant'],  'prompt':  ['fg', 'Character'],  'pointer': ['fg', 'Exception'],  'marker':  ['fg', 'Keyword'],  'spinner': ['fg', 'Label'],  'header':  ['fg', 'Comment'] }")
