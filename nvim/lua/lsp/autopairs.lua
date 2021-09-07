-- Settings
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

-- cmp basd autopairs
require("nvim-autopairs.completion.cmp").setup({
  map_cr = true,
  map_complete = true
})

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},
        javascript = {'template_string'},
        java = false,
    }
})


-- Treesitter checking of autopairs
require('nvim-treesitter.configs').setup {
    autopairs = {enable = true}
}

local ts_conds = require('nvim-autopairs.ts-conds')

npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})
