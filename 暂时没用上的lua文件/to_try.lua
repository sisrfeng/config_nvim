现在没用上:



https://github.com/chentau/marks.nvim


require'marks'.setup {
    default_mappings = false,
    -- builtin_marks = { ".", "<", ">", "^" },
    builtin_marks = {  },
        -- which builtin marks to show. default {}
    cyclic = true,
        -- whether movements cycle back to the beginning/end of buffer. default true
    force_write_shada = false,
        -- whether the shada file is updated after modifying uppercase marks. default false
    refresh_interval = 250,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
    sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
        -- default 10.
    excluded_filetypes = {  },
        -- disables mark tracking for specific filetypes. default {}
    bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world"
    },
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
    mappings = {
        set = "m",
        delete = "dm"
          -- set_next               Set the next available alphabetical mark
          -- set                    Set a named mark (will wait for input).
          -- toggle                 Toggle a mark at the cursor.
          -- next                   Move to the next mark
          -- prev                   Move to the previous mark.
          -- delete                 Delete a mark (will wait for input).
          -- delete_line            Delete the marks on the current line.
          -- delete_buf             Delete all marks in the buffer.
          -- preview                Preview a mark.
          --
          -- set_bookmark[0-9]      Sets a bookmark from group[0-9].
          -- delete_bookmark[0-9]   Deletes all bookmarks from group[0-9].
          -- delete_bookmark        Deletes the bookmark under the cursor.
          -- next_bookmark          Moves to the next bookmark having the same type as the
          --                        bookmark under the cursor.
          -- prev_bookmark          Moves to the previous bookmark having the same type as the
          --                        bookmark under the cursor.
          -- next_bookmark[0-9]     Moves to the next bookmark of of the same group type. Works by
          --                        first going according to line number, and then according to buffer
          --                        number.
          -- prev_bookmark[0-9]     Moves to the previous bookmark of of the same group type. Works by
          --                        first going according to line number, and then according to buffer
          --                        number.
          -- annotate               Prompts the user for a virtual line annotation that is then placed
          --                        above the bookmark. Requires neovim 0.6+ and is not mapped by default.
    }

}



其他lua配置 待续



另外一个插件, 要从vimL改回lua

" reload init.vim时老是有warning
"     lua << end_of_lua
"         require("todo-comments").setup {
"             signs = false,     -- show icons in the signs column(左侧栏)
"             sign_priority = 8, -- sign priority
"
"             -- keywords recognized as todo comments
"             keywords = {
"                 FIX = {
"                     icon = " ", -- icon used for the sign, and in search results
"                     color = "#b4b4c4",
"                     alt = { "buggy?", "buggy", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
"                     signs = false, -- configure signs for some keywords individually
"                         },
"                 TODO = { icon = " ",
"                         alt = { "todo", "to_do", "to do" },
"                         color = "#a4c4b4"
"                         },
"             },
"                 -- don't replace the (KEYWORDS) placeholder
"                 -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
"                 pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
"             },
"         }
" -- end_of_lua不能有缩进 (EOF前的这一坨 是lua语言)
" end_of_lua
" " end_of_lua不能有缩进

