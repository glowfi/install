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
vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_custom_section = {
    a = {description = {'  Find File          '}, command = 'Telescope find_files'},
    b = {description = {'  Find Word          '}, command = 'Telescope live_grep'},
    c = {description = { "  Recently Used Files" },command = "Telescope oldfiles",},
    d = {description = {'  Open Folder        '}, command = ':RnvimrToggle'},
    e = {description = {'  Load Last Session  '}, command = ':SessionLoad last'},
    f = {description = {'  Settings           '}, command = ':e '..CONFIG_PATH..'/init.lua'},
    g = {description = {'  Close              '}, command = ':qall'},
    }

-- Session Keymappings
vim.cmd("nmap <S-q> :SessionSave last<CR>")
