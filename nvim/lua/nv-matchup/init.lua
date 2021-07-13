-- Match brackets
require'nvim-treesitter.configs'.setup {
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
--     disable = { "c", "ruby" },  -- optional, list of language that will be disabled
  },
}

vim.cmd "let g:matchup_surround_enabled = 1"
vim.g.matchup_matchparen_offscreen = {method = 'popup'}
