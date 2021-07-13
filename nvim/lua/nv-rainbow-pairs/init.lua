-- Rainbow brackets with treesitter integration

require'nvim-treesitter.configs'.setup {
      rainbow = {
                enable = true,
                -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
                extended_mode = true,
                -- Do not enable for files with more than 1000 lines, int
                max_file_lines = 1000,
                }
            }
