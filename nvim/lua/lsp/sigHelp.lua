-- Settings
 cfg = {
  bind = true,
  doc_lines = 2,
  floating_window = true,
  fix_pos = false,
  hint_enable = true,
  hint_prefix = "🐼 ",
  hint_scheme = "String",
  use_lspsaga = false,
  hi_parameter = "Search",
  max_height = 12,
  max_width = 120,
  handler_opts = {
    border = "shadow"
  },
  extra_trigger_chars = {"(", ","},
  zindex = 200,
  debug = false,
  log_path = "debug_log_file_path",
  padding = '',
  shadow_blend = 36,
  shadow_guibg = 'Black'
}

require'lsp_signature'.setup(cfg)
