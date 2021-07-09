-- Vim API
local execute = vim.api.nvim_command
local fn = vim.fn

-- Packer Plugins Install Path
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

packer.init {
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

  -- Plugins
return require('packer').startup(function(use)

  -- Packer Plugin Manager
  use 'wbthomason/packer.nvim'

  -- Ranger File Manager
  use 'kevinhwang91/rnvimr'

  -- Neovim File Tree
  use 'kyazdani42/nvim-tree.lua'

  -- Devicons
  use 'kyazdani42/nvim-web-devicons'
  use 'ryanoasis/vim-devicons'

  -- Status line
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- Fuzzy search
  use {'junegunn/fzf.vim',event = "BufRead"}
  use {'junegunn/fzf',event = "BufRead"}

  -- Git Integration
  use 'tpope/vim-fugitive'
  use 'mhinz/vim-signify'

   -- Dashboard
  use {'glepnir/dashboard-nvim',event = "BufWinEnter",}

  -- Code Runner
  use 'sbdchd/vim-run'

  -- Multi Cursor
  use {'mg979/vim-visual-multi', branch = 'master'}

  -- Auto Comment
  use {'KarimElghamry/vim-auto-comment',event = "BufRead",}

  -- Tabs
  use 'romgrk/barbar.nvim'

  -- Treesitter
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Treesitter Rainbow pairs
  use 'p00f/nvim-ts-rainbow'

  -- Bracket Matchup
  use 'andymass/vim-matchup'

  -- Gruvbox theme
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  -- Nvim LSP and autocompletions
  use 'neovim/nvim-lspconfig'
  use {'kabouzeid/nvim-lspinstall',event = "BufRead"}
  use 'glepnir/lspsaga.nvim'
  use {'hrsh7th/nvim-compe',event = "InsertEnter"}
  use {'hrsh7th/vim-vsnip',event = "InsertEnter"}

  -- Snippets
  use "rafamadriz/friendly-snippets"
  use 'dsznajder/vscode-es7-javascript-react-snippets'

  -- Auto pairs
  use {'windwp/nvim-autopairs',event = "InsertEnter"}

  -- Auto format document
  use 'Chiel92/vim-autoformat'

  -- COC
--   use {'neoclide/coc.nvim', branch = 'release'}
end)
