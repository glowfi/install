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
  use {'junegunn/fzf.vim'}
  use {'junegunn/fzf'}

  -- Git Integration
  use 'tpope/vim-fugitive'
  use 'mhinz/vim-signify'

   -- Dashboard
  use {'glepnir/dashboard-nvim'}

  -- Code Runner
  use 'sbdchd/vim-run'

  -- Multi Cursor
  use {'mg979/vim-visual-multi', branch = 'master'}

  -- Auto Comments
  use {"terrortylor/nvim-comment"}

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
  use {'kabouzeid/nvim-lspinstall'}
--   use 'glepnir/lspsaga.nvim'
  use {'hrsh7th/nvim-compe'}
  use {'hrsh7th/vim-vsnip'}
  use {"ray-x/lsp_signature.nvim"}

  -- Snippets
  use "rafamadriz/friendly-snippets"
  use 'dsznajder/vscode-es7-javascript-react-snippets'

  -- Auto pairs
  use {'windwp/nvim-autopairs'}

  -- Auto format document
  use "mhartington/formatter.nvim"

  -- Cursorhold Fix
  use 'antoinemadec/FixCursorHold.nvim'
  vim.cmd("let g:cursorhold_updatetime = 100")

  -- Indentline
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"

      vim.g.indent_blankline_filetype_exclude = {
        "help",
        "terminal",
        "dashboard",
      }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }

      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = true
    end,
  }

end)
