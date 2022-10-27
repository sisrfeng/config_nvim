目前没有文件source/require本文件

vim.cmd('echom "读取wf_lua.lua"')  -- 还是要重开nvim的session, 本文件的新内容才生效


--:help ui-paste:
        -- You can implement a custom paste handler by redefining |vim.paste()|.
        -- Example: >
        --
        --   vim.paste = (function(lines, phase)
        --     v"vim.paste"im.api.nvim_put(lines, 'c', true, true)
        --   end)

-- 这里在生效!!
-- 如果让函数啥也不干, ctrl v在insort mode和normal mode下都没动静
-- (windows terminal控制了ctrl v为粘贴, vim无法map. ctrl v传给vim.paste函数(vim有默认的) 实现粘贴?)
        vim.paste = (function(lines, phase)
                        vim.cmd('echom "normal模式和insert模式下, ctrl_v粘贴会调用 wf_lua.lua里的vim.paste, 不过好像没起变化"')
                                -- 这样echo的消息, 不敲:message不弹出来
                        -- vim.cmd('!mkdir -p ~/.t/llllllllll')  -- 会生效

                        -- print('lualualua')  -- print到哪里?
                        -- os.execute("mkdir " .. "~/.t/lualua_nvim" )  -- 不生效,
                                                                        -- 因为这里被vim调用, 而不是纯lua?

                        -- 没有vim.put
                        -- 本来用的是 nvim_paste, 这里换成nvim_put
                        vim.api.nvim_put(lines,   'c',    true,    true)

                    end)


                            -- nvim_put({lines}, {type}, {after}, {follow})
                            --                     • "c" |charwise| mode
                            --                     • "l" |linewise| mode
                            --                             {after}   If true insert after cursor (like |p|),
                            --                                     {follow}  If true place cursor at end of inserted text.
                            --
                            --
                                                        --
                                                        --                            --                            --
                                                        --                                                        --                            --                            --                            --                            --
                                                        --



-- 参考:
        --
        -- paste({lines}, {phase})                                          *vim.paste()*
        --                 Paste handler, invoked by |nvim_paste()| when a conforming UI
        --                 (such as the |TUI|) pastes text into the editor.
        --
        --                 Example: To remove ANSI color codes when pasting: >
        --
        --                  vim.paste = (function(overridden)
        --                    return function(lines, phase)
        --                      for i,line in ipairs(lines) do
        --                        -- Scrub ANSI color codes from paste input.
        --                        lines[i] = line:gsub('\27%[[0-9;mK]+', '')
        --                      end
        --                      overridden(lines, phase)
        --                    end
        --                  end)(vim.paste)
        --                  自己调用自己?
        -- 
        --
        --                 Parameters: ~
        --                     {lines}  |readfile()|-style list of lines to paste.
        --                              |channel-lines|
        --                     {phase}  -1: "non-streaming" paste: the call contains all
        --                              lines. If paste is "streamed", `phase` indicates the stream state:
        --                              • 1: starts the paste (exactly once)
        --                              • 2: continues the paste (zero or more times)
        --                              • 3: ends the paste (exactly once)
        --
        --                 Return: ~
        --                     false if client should cancel the paste.
        --
        --                 See also: ~
        --                     |paste|
        --
        --
        -- nvim_input({keys})                                              *nvim_input()*
        --                 Queues raw user-input. Unlike |nvim_feedkeys()|, this uses a
        --                 low-level input buffer and the call is non-blocking (input is
        --                 processed asynchronously by the eventloop).
        --
        --                 On execution error: does not fail, but updates v:errmsg.
        --
        --                 Note:
        --                     |keycodes| like <CR> are translated, so "<" is special. To
        --                     input a literal "<", send <LT>.
        --
        --                 Note:
        --                     For mouse events use |nvim_input_mouse()|. The pseudokey
        --                     form "<LeftMouse><col,row>" is deprecated since
        --                     |api-level| 6.
        --
        --                 Attributes: ~
        --                     {fast}
        --
        --                 Parameters: ~
        --                     {keys}  to be typed
        --
        --                 Return: ~
        --                     Number of bytes actually written (can be fewer than
        --                     requested if the buffer becomes full).
        --
        --
        -- nvim_paste({data}, {crlf}, {phase})                             *nvim_paste()*
        --                 Pastes at cursor, in any mode.
        --
        --                 Invokes the `vim.paste` handler, which handles each mode
        --                 appropriately. Sets redo/undo. Faster than |nvim_input()|.
        --                 Lines break at LF ("\n").
        --
        --                 Errors ('nomodifiable', `vim.paste()` failure, …) are
        --                 reflected in `err` but do not affect the return value (which
        --                 is strictly decided by `vim.paste()` ). On error, subsequent
        --                 calls are ignored ("drained") until the next paste is
        --                 initiated (phase 1 or -1).
        --
        --                 Attributes: ~
        --                     not allowed when |textlock| is active
        --
        --                 Parameters: ~
        --                     {data}   Multiline input. May be binary (containing NUL
        --                              bytes).
        --                     {crlf}   Also break lines at CR and CRLF.
        --                     {phase}  -1: paste in a single call (i.e. without
        --                              streaming). To "stream" a paste, call `nvim_paste` sequentially with these `phase` values:
        --                              • 1: starts the paste (exactly once)
        --                              • 2: continues the paste (zero or more times)
        --                              • 3: ends the paste (exactly once)
        --
        --                 Return: ~
        --
        --                     • true: Client may continue pasting.
        --                     • false: Client must cancel the paste.
        --
        -- nvim_paste vs nvim_put  就像 |:put| vs  |p| which are always linewise.
        --
        -- nvim_put({lines}, {type}, {after}, {follow})                      *nvim_put()*
        --                 Puts text at cursor, in any mode.
        --
        --                 Attributes: ~
        --                     not allowed when |textlock| is active
        --
        --                 Parameters: ~
        --                     {lines}   |readfile()|-style list of lines.
        --                               |channel-lines|
        --                     {type}    Edit behavior: any |getregtype()| result, or:
        --                               • "b" |blockwise-visual| mode (may include
        --                                 width, e.g. "b3")
        --                               • "c" |charwise| mode
        --                               • "l" |linewise| mode
        --                               • "" guess by contents, see |setreg()|
        --                     {after}   If true insert after cursor (like |p|), or
        --                               before (like |P|).
        --                     {follow}  If true place cursor at end of inserted text.
        --
        --
        -- 这个不是lua里面的:
        --                             *:pu* *:put*
        -- :[line]pu[t] [x]
        -- 和normal mode下敲p区别不大
        -- Put the text [from register x] after [line] (default
        -- current line).
        -- This always works |linewise|, thus  this command can be used to put a yanked block as new  lines.
        --
        --
        --
        --
