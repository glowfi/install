-- Settings
local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
        b.formatting.prettier.with {
        filetypes = {
          "typescriptreact",
          "typescript",
          "javascriptreact",
          "javascript",
          "css",
          "html",
        },
      },
         b.formatting.black.with {
        filetypes = {"python"},
    }
}

local M = {}
M.setup = function(on_attach)
    null_ls.config({
        debounce = 150,
        sources = sources,
    })
    require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
end

return M
