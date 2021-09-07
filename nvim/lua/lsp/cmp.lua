-- Settings
vim.o.completeopt = "menuone,noselect"
vim.cmd "let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']"

local cmp = require'cmp'

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end


cmp.setup {

  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end
  },

  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

  ['<Tab>'] = function(fallback)
    if vim.fn.pumvisible() == 1 then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
    elseif check_back_space() then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n')
    elseif vim.fn['vsnip#available']() == 1 then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
    else
      fallback()
    end
  end,

    ['<S-Tab>'] = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
      return t "<Plug>(vsnip-jump-prev)"
    else
      return t "<S-Tab>"
    end
  end
  },

  documentation = {
      border = "single",
      winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
      max_width = 120,
      min_width = 60,
      max_height = math.floor(vim.o.lines * 0.3),
      min_height = 1,
    },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'vsnip' }
  },

  formatting = {
  format = function(entry, vim_item)

    local comp_kind= {
    Text ="   (Text) ",
    Method ="   (Method)",
    Function ="   (Function)",
    Constructor ="   (Constructor)",
    Field ="   (Field)",
    Variable ="[] (Variable)",
    Class ="   (Class)",
    Interface =" 蘒 (Interface)",
    Module ="   (Module)",
    Property ="   (Property)",
    Unit ="   (Unit)",
    Value ="   (Value)",
    Enum =" 練 (Enum)",
    Keyword ="   (Keyword)",
    Snippet ="   (Snippet)",
    Color ="   (Color)",
    File ="   (File)",
    Reference ="   (Reference)",
    Folder ="   (Folder)",
    EnumMember ="   (EnumMember)",
    Constant ="   (Constant)",
    Struct ="   (Struct)",
    Event ="   (Event)",
    Operator ="   (Operator)",
    TypeParameter ="   (TypeParameter)"
     }

    vim_item.kind = comp_kind[vim_item.kind]
    vim_item.menu = ({
      nvim_lsp =  "[LSP]",
      vsnip =  "[VSNIP]",
      path = "[Path]",
      buffer =  "[Buffer]"
    })[entry.source.name]
    return vim_item
  end,
}
}
