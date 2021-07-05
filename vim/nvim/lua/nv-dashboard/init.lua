-- CUSTOM HEADER
local custom_header = {
 ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
 ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
 ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
 ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
 ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
 ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}

-- CUSTOM FOOTER
local custom_footer= {''}

-- SETTING CUSTOM HEADER AND FOOTER
vim.g.dashboard_custom_header=custom_header
vim.g.dashboard_custom_footer=custom_footer

-- CHANGE START SCREEN
vim.g.dashboard_default_executive = 'fzf'
vim.g.dashboard_custom_section = {
    a = {description = {'  Find File          '}, command = ':Files'},
    b = {description = {'  Find Word          '}, command = ':Rg'},
    c = {description = {'  Settings           '}, command = ':e '..CONFIG_PATH..'/init.lua'},
    d = {description = {'  Close              '}, command = ':qall'},
--     e = {description = {'  Close              '}, command = ':qall'},
}
