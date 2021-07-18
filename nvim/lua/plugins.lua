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
      return require("packer.util").float { border = "none" }
    end,
  },
}

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

-- Plugins
return require('packer').startup(function(use)

    -- Packer Plugin Manager
    use 'wbthomason/packer.nvim'

-- Utilities

    -- Ranger File Manager
    use 'kevinhwang91/rnvimr'

    -- Fuzzy search
    use  'nvim-telescope/telescope.nvim'
    use  'nvim-lua/popup.nvim'
    use  'nvim-lua/plenary.nvim'
    use  'nvim-telescope/telescope-fzy-native.nvim'

    -- Git Integration
    use 'lewis6991/gitsigns.nvim'

    -- Code Runner
    use 'sbdchd/vim-run'

    -- Multi Cursor
    use {'mg979/vim-visual-multi', branch = 'master'}

    -- Auto Comments
    use {"terrortylor/nvim-comment"}

    -- Tabs
    use 'romgrk/barbar.nvim'

    -- Cursorhold Fix
    use 'antoinemadec/FixCursorHold.nvim'
    vim.cmd "let g:cursorhold_updatetime = 100"

    -- Colorizer
    use 'norcalli/nvim-colorizer.lua'
    require 'colorizer'.setup()



-- Ricing

    -- Gruvbox theme
    use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

    -- Status line
    use 'hoob3rt/lualine.nvim'

    -- Devicons
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'

    -- Dashboard
    use 'glepnir/dashboard-nvim'

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

-- Treesitter integrations

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

    -- Treesitter text-objects
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    -- Treesitter(integrated) Rainbow pairs
    use 'p00f/nvim-ts-rainbow'

    -- Bracket Matchup
    use 'andymass/vim-matchup'


-- Native LSP (ENGINE)

    --   Nvim native LSP
    use 'neovim/nvim-lspconfig'

    --   Auto completion
    use {'hrsh7th/nvim-compe'}

    --   Snippet engine
    use {'hrsh7th/vim-vsnip'}

    --   Signature popup on typing
    use {"ray-x/lsp_signature.nvim"}

    --   Auto format document
    use "mhartington/formatter.nvim"

    --   Auto pairs
    use {'windwp/nvim-autopairs'}


-- Languages Plugins

    --   Snippets
    use "rafamadriz/friendly-snippets"
    use 'dsznajder/vscode-es7-javascript-react-snippets'

    --   Typescript
    use "jose-elias-alvarez/null-ls.nvim"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"

    --   Graphql
    use 'jparise/vim-graphql'
end)
