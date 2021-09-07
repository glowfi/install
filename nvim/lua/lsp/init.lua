-- Settings
-- Load Null-ls
local null_ls = require("lsp.null-ls")


-- Lsp Diagnostic signs
vim.fn.sign_define(
  "LspDiagnosticsSignError",
  { texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError" }
)
vim.fn.sign_define(
  "LspDiagnosticsSignWarning",
  { texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning" }
)
vim.fn.sign_define(
  "LspDiagnosticsSignHint",
  { texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint" }
)
vim.fn.sign_define(
  "LspDiagnosticsSignInformation",
  { texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation" }
)

-- Keymappings
vim.cmd 'nnoremap <silent> <F2> <cmd>lua vim.lsp.buf.rename()<CR>'
vim.cmd 'nnoremap <silent> <F1> <cmd>lua vim.lsp.buf.code_action()<CR>'
vim.cmd "nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>"
vim.cmd "nnoremap <silent> ga <cmd>lua vim.lsp.buf.declaration()<CR>"
vim.cmd "nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>"
vim.cmd "nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>"
vim.cmd "nnoremap <S-p>  :lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = 'single'}})<CR>"
vim.cmd "nnoremap <S-n>  :lua vim.lsp.diagnostic.goto_next({popup_opts = {border = 'single'}})<CR>"
vim.cmd 'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()'


-- Set Default Prefix.
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
        prefix = "",
        spacing = 3,
    },
    signs = true,
    underline = true,
    update_in_insert = true
  }
)


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single"
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "single"
})


-- Symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    "   (Field)",
    "[] (Variable)",
    "   (Class)",
    " 蘒 (Interface)",
    "   (Module)",
    "   (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    "   (Constant)",
    "   (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

local function documentHighlight(client, bufnr)
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
        )
    end
end


local lsp_config = {}

-- Document Highlighting
function lsp_config.common_on_attach(client, bufnr)
    documentHighlight(client, bufnr)
end

-- Format on Save
local buf_augroup = function(name, event, fn)
    vim.api.nvim_exec(
        string.format(
            [[
    augroup %s
        autocmd! * <buffer>
        autocmd %s <buffer> %s
    augroup END
    ]],
            name,
            event,
            fn
        ),
        false
    )
end

local format_ = function(client, bufnr)
    if client.resolved_capabilities.document_formatting then
        buf_augroup("LspFormatOnSave", "BufWritePre", "lua vim.lsp.buf.formatting_sync()")
    end
end

-- CMP SUPPORT
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)


-- Python LSP
require'lspconfig'.pyright.setup{
capabilities = capabilities,
}


-- HTML CSS
require'lspconfig'.html.setup {
  capabilities = capabilities,
}

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

-- Emmet
local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

if not lspconfig.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = {'emmet-ls', '--stdio'};
      filetypes = { "html", "css"},
      root_dir = function(fname)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end
lspconfig.emmet_ls.setup{ capabilities = capabilities, }

-- JSON
require'lspconfig'.jsonls.setup {}


-- GraphQL
 require("lspconfig").graphql.setup {
     on_attach = common_on_attach,
     cmd = { "graphql-lsp", "server", "-m", "stream" },
     filetypes = { "graphql" },
     root_dir = require("lspconfig/util").root_pattern('.git', '.graphqlrc',"**/*.{graphql,js,ts,jsx,tsx}")}


-- TS TSX JS JSX
local nvim_lsp = require("lspconfig")
nvim_lsp.tsserver.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup {
            debug = false,
            disable_commands = false,
            enable_import_on_completion = true,
            import_all_timeout = 5000, -- ms

            -- Eslint
            eslint_enable_code_actions = true,
            eslint_enable_disable_comments = true,
            eslint_bin = "eslint_d",
            eslint_config_fallback = nil,
            eslint_enable_diagnostics = false,

            -- Formatting
            enable_formatting = true,
            formatter = "prettierd",
            formatter_opts = {},

            -- Update imports on file move
            import_all_scan_buffers = 100,
            update_imports_on_move = true,
            require_confirmation_on_move = false,
            watch_dir = nil,
        }

        -- Required to fix code action ranges
        ts_utils.setup_client(client)

        -- Keymappings
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", {silent = true})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", {silent = true})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", {silent = true})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", {silent = true})
    end,
     flags = {
            debounce_text_changes = 150,
    },
}


-- Null-ls Integration
 null_ls.setup(format_)
