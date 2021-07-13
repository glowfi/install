-- Global Paths
CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

-- General Settings
require('settings')
require('keymaps')
require('plugins')

-- Utility Plugins
require('nv-ranger')
require('nv-telescope')
require('nv-coderunner')
require('nv-git-signs')
require('nv-autocomments')
require('nv-barbar')

-- Ricing Plugins
require('nv-gruvbox')
require('nv-dashboard')
require('nv-lualine')

-- Treesitter Plugins
require('nv-treesitter')
require('nv-treesitter-textobjects')
require('nv-rainbow-pairs')
require('nv-matchup')

-- Native LSP Plugins
require('nv-lsp')
require('nv-completions')
require('nv-vsnip')
require('nv-autopairs')
require('nv-autoformat')
require('nv-sig-help')
