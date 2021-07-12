-- LSP setup

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
vim.cmd "nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>"
vim.cmd "nnoremap <silent> gp <cmd>lua require'lsp'.PeekDefinition()<CR>"
vim.cmd "nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>"
vim.cmd "nnoremap <silent> <c-[> :lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = 'single'}})<CR>"
vim.cmd "nnoremap <silent> <c-]> :lua vim.lsp.diagnostic.goto_next({popup_opts = {border = 'single'}})<CR>"
vim.cmd 'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()'


-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "",
      spacing = 0,
    },
    signs = true,
    underline = true,
  }
)


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "single",
})


-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
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


function lsp_config.preview_location(location, context, before_context)
  -- location may be LocationLink or Location (more useful for the former)
  context = context or 15
  before_context = before_context or 0
  local uri = location.targetUri or location.uri
  if uri == nil then
    return
  end
  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    vim.fn.bufload(bufnr)
  end

  local range = location.targetRange or location.range
  local contents = vim.api.nvim_buf_get_lines(
    bufnr,
    range.start.line - before_context,
    range["end"].line + 1 + context,
    false
  )
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  return vim.lsp.util.open_floating_preview(contents, filetype, { border = O.lsp.popup_border })
end

function lsp_config.preview_location_callback(_, method, result)
  local context = 15
  if result == nil or vim.tbl_isempty(result) then
    print("No location found: " .. method)
    return nil
  end
  if vim.tbl_islist(result) then
    lsp_config.floating_buf, lsp_config.floating_win = lsp_config.preview_location(result[1], context)
  else
    lsp_config.floating_buf, lsp_config.floating_win = lsp_config.preview_location(result, context)
  end
end

function lsp_config.PeekDefinition()
  if vim.tbl_contains(vim.api.nvim_list_wins(), lsp_config.floating_win) then
    vim.api.nvim_set_current_win(lsp_config.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/definition", params, lsp_config.preview_location_callback)
  end
end

function lsp_config.PeekTypeDefinition()
  if vim.tbl_contains(vim.api.nvim_list_wins(), lsp_config.floating_win) then
    vim.api.nvim_set_current_win(lsp_config.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/typeDefinition", params, lsp_config.preview_location_callback)
  end
end

function lsp_config.PeekImplementation()
  if vim.tbl_contains(vim.api.nvim_list_wins(), lsp_config.floating_win) then
    vim.api.nvim_set_current_win(lsp_config.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/implementation", params, lsp_config.preview_location_callback)
  end
end




function lsp_config.common_on_attach(client, bufnr)
    documentHighlight(client, bufnr)
end
function lsp_config.tsserver_on_attach(client, bufnr)
    lsp_config.common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
end
