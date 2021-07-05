-- Jump forward or backward
vim.cmd("imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'")
vim.cmd("smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'")
vim.cmd("imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'")
vim.cmd("smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'")


-- Enable Snippets
vim.cmd("let g:vsnip_filetypes = {}")
vim.cmd("let g:vsnip_filetypes.javascriptreact = ['javascript']")
vim.cmd("let g:vsnip_filetypes.typescriptreact = ['typescript']")
vim.cmd("let g:vsnip_filetypes.typescriptreact = ['javascriptreact']")
vim.cmd("let g:vsnip_filetypes.typescriptreact = ['typescriptreact']")
vim.cmd("let g:vsnip_filetypes.typescriptreact = ['python']")
