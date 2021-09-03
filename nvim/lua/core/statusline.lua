-- Import Lualine
local lualine = require 'lualine'

-- Conditions
local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end
}

-- Define colors
local colors = {
  bg = '#282828',
  fg = '#ebdbb2',
  red = '#fb4934',
  green = '#b8bb26',
  yellow = '#fabd2f',
  blue = '#83a598',
  purple = '#d3869b',
  aqua = '#8ec07c',
  orange = '#fe8019',
  gray = '#928374'
}

-- Config
local config = {
 options = {
    icons_enabled = true,
    theme = 'gruvbox_material',
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {}
  }
    }

-- Status line

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end


-- Left Section

-- Git branch
ins_left {
  'branch',
  icon = '',
  condition = conditions.check_git_workspace,
  color = {bg = '#e6e6e6',fg = '#000000', gui = 'bold'}
}

-- Git diff
ins_left {
  'diff',
  symbols = {added = ' ', modified = '柳 ', removed = ' '},
  color_added = colors.green,
  color_modified = colors.blue,
  color_removed = colors.red,
  condition = conditions.hide_in_width,
}

-- Python Virtual Environment
local function env_cleanup(venv)
  if string.find(venv, "/") then
    local final_venv = venv
    for w in venv:gmatch "([^/]+)" do
      final_venv = w
    end
    venv = final_venv
  end
  return venv
end
local PythonEnv = function()
  if vim.bo.filetype == "python" then
    local venv = os.getenv "CONDA_DEFAULT_ENV"
    if venv ~= nil then
      return "Venv ->  (" .. env_cleanup(venv) .. ")"
    end
    venv = os.getenv "VIRTUAL_ENV"
    if venv ~= nil then
      return "Venv ->  (" .. env_cleanup(venv) .. ")"
    end
    return ""
  end
  return ""
end

ins_left {
    PythonEnv,
    color = {fg = colors.orange, gui = 'bold'}
}

-- Python Version
local PythonVer = function()
  if vim.bo.filetype == "python" then
    local handle = io.popen("python --version")
    local var = handle:read("*a")
    handle:close()
    local s=var:sub(1, -2)
    return s
  end
end

-- Node Version
local NodeVer = function()
  if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" or vim.bo.filetype == "javascriptreact" or vim.bo.filetype == "typescriptreact" then
    local handle = io.popen("node --version")
    local var = handle:read("*a")
    handle:close()
    local s=var:sub(1, -2)
    return "node " .. s
  end
end

ins_left {
    PythonVer,
    color = {fg = '#ffffff', gui = 'bold'}
}

ins_left {
    NodeVer,
    color = {fg = '#ffffff', gui = 'bold'}
}

-- Diagnostics
ins_left {
  'diagnostics',
  sources = {'nvim_lsp'},
  symbols = {error = ' ', warn = ' ', info = ' '},
  color_error = colors.red,
  color_warn = colors.yellow,
  color_info = colors.blue
}


-- Right Section

-- Treesitter
local treesitter=function()
      if next(vim.treesitter.highlighter.active) ~= nil then
        return " (treesitter)"
      end
      return ""
    end

ins_right {
    treesitter,
    color = {fg = colors.green, gui = 'bold'}
}

-- LSP STATUS
local get_attached_provider_name=function()
      if vim.bo.filetype == "dashboard" then
          return ""
      else
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then return msg end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end
    end

ins_right {
    get_attached_provider_name,
    icon = '',
    color = {fg = '#ffffff', gui = 'bold'}
}

-- Location
ins_right {'location',
           color = {fg = '#ffffff', gui = 'bold'}
          }

-- Progress
-- ins_right {'progress',
--            color = {fg = '#ffffff', gui = 'bold'}
--           }


-- Spaces_and_Tabs
local get_space_tabs=function()
      local label = "Spaces: "
      if not vim.api.nvim_buf_get_option(0, "expandtab") then
        label = "Tab size: "
      end
      return label .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
    end

ins_right {
    get_space_tabs,
    color = {fg = '#ffffff', gui = 'bold'}
    }

ins_right {
    'filetype',
    color = {fg = '#ffffff', gui = 'bold'}
    }

-- File size
-- local fsize=  function()
--     local function format_file_size(file)
--       local size = vim.fn.getfsize(file)
--       if size <= 0 then return '' end
--       local sufixes = {'b', 'k', 'm', 'g'}
--       local i = 1
--       while size > 1024 do
--         size = size / 1024
--         i = i + 1
--       end
--       return string.format('%.1f%s', size, sufixes[i])
--     end
--     local file = vim.fn.expand('%:p')
--     if string.len(file) == 0 then return '' end
--     return format_file_size(file)
--   end

-- ins_right {
--     fsize,
--     color = {fg = '#ffffff', gui = 'bold'}
--     }

-- Encoding
ins_right {
    'encoding',
    color = {fg = '#ffffff', gui = 'bold'}
}

-- Initialize lualine
lualine.setup(config)
