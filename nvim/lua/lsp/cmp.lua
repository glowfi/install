-- Settings
vim.o.completeopt = "menuone,noselect,noinsert"
vim.cmd "let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']"

local cmp = require'cmp'

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
