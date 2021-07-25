-- Dashboard

-- CUSTOM HEADER
local custom_header={
'               ,   ,                             ',
'               $,  $,     ,                      ',
'               "ss.$ss. .s"                      ',
'       ,     .ss$$$$$$$$$$s,                     ',
'       $. s$$$$$$$$$$$$$$`$$Ss                   ',
'       "$$$$$$$$$$$$$$$$$$o$$$       ,           ',
'      s$$$$$$$$$$$$$$$$$$$$$$$$s,  ,s            ',
'     s$$$$$$$$$"$$$$$$""""$$$$$$"$$$$$,          ',
'     s$$$$$$$$$$s""$$$$ssssss"$$$$$$$$"          ',
'    s$$$$$$$$$$"         `"""ss"$"$s""           ',
'    s$$$$$$$$$$,              `"""""$  .s$$s     ',
'    s$$$$$$$$$$$$s,...               `s$$"  `    ',
'`ssss$$$$$$$$$$$$$$$$$$$$####s.     .$$"$.   , s-',
'  `""""$$$$$$$$$$$$$$$$$$$$#####$$$$$$"     $.$" ',
'        "$$$$$$$$$$$$$$$$$$$$$####s""     .$$$|  ',
'         "$$$$$$$$$$$$$$$$$$$$$$$$##s    .$$" $  ',
'          $$""$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"   ` ',
'         $$"  "$"$$$$$$$$$$$$$$$$$$$$S"""""      ',
'    ,   ,"     $  $$$$$$$$$$$$$$$$####s          ',
'    $.          .s$$$$$$$$$$$$$$$$$####"         ',
'    "$sssssssssS$$$$$$$$$$$$$$$$$$$####"         ',
}

-- CUSTOM FOOTER
local custom_footer= {'Welcome to Dragon Inn!'}

-- SETTING CUSTOM HEADER AND FOOTER
vim.g.dashboard_custom_header=custom_header
vim.g.dashboard_custom_footer=custom_footer

-- CHANGE START SCREEN
vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_custom_section = {
    a = {description = {'  Find File          '}, command = 'Telescope find_files'},
    b = {description = {'  Find Word          '}, command = 'Telescope live_grep'},
    c = {description = {'  Recently Used Files'}, command = "Telescope oldfiles",},
    }
