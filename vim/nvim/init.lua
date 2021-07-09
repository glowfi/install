-- Global Paths
CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

-- General Settings
require('settings')
require('keymaps')
require('plugins')

-- Global Plugins
require('nv-ranger')
require('nv-airline')
require('nv-fzf')
require('nv-dashboard')
require('nv-coderunner')
require('nv-signify')
require('nv-treesitter')
require('nv-rainbow-pairs')
require('nv-gruvbox')
require('nv-matchup')
require('nv-tree')
require('nv-barbar')

-- LSP
require('nv-lsp')
require('nv-lsp-install')
require('nv-completions')
require('nv-vsnip')
require('nv-autopairs')
require('nv-autoformat')
require('nv-lsp-saga')

-- COC
-- vim.cmd('source $HOME/.config/nvim/coc.vim')
