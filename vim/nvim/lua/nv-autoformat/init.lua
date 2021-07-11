-- Format on save

-- Python
local black = function()
  return {exe = "black", args = {"-q", "-"}, stdin = true}
end


require('formatter').setup({
  logging = false,
  filetype = {
    python = { black },
  }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.py FormatWrite
augroup END
]], true)
