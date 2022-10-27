" Maintainer:   Zvezdan Petkovic <zpetkovic@acm.org>
    " Last Change:  2021 Dec 10
    "\ This version is a major rewrite by Zvezdan Petkovic.

"       - corrected ¿synchronization¿
    "
    " Optional highlighting can be controlled using these variables.

    "   let python_no_builtin_highlight = 1
    "   let python_no_doctest_code_highlight = 1
    "   let python_no_doctest_highlight = 1
    "   let python_no_exception_highlight = 1
    "   let python_no_number_highlight = 1
      let python_space_error_highlight = 1

    " All the options above can be switched on together.

    "   let python_highlight_all = 1

if exists("b:current_syntax")
    finish
endif

" options for users
    if exists("python_no_doctest_highlight")
        let python_no_doctest_code_highlight = 1
    endif

    if exists("python_highlight_all")
        if exists("python_no_builtin_highlight")
            unlet python_no_builtin_highlight
        endif
        if exists("python_no_doctest_code_highlight")
            unlet python_no_doctest_code_highlight
        endif
        if exists("python_no_doctest_highlight")
            unlet python_no_doctest_highlight
        endif
        if exists("python_no_exception_highlight")
            unlet python_no_exception_highlight
        endif
        if exists("python_no_number_highlight")
            unlet python_no_number_highlight
        endif
        let python_space_error_highlight = 1
    endif

" Keep Python keywords in alphabetical order inside groups
    " for easy comparison with the table in the 'Python Language Reference' https://docs.python.org/reference/lexical_analysis.html#keywords.
    " Groups are in the order presented in NAMING CONVENTIONS in syntax.txt.
    " Exceptions come last at the end of each group (class and def below).

    " The list can be checked using:
    " python3 -c 'import keyword, pprint; pprint.pprint(keyword.kwlist + keyword.softkwlist, compact=True)'

    syn keyword pyStatement     False None True
    syn keyword pyStatement     as assert break continue del global
    syn keyword pyStatement     lambda nonlocal pass return with yield
    syn keyword pyStatement     class def nextgroup=pythonFunction skipwhite
    syn keyword pyConditional   elif else if
    syn keyword pyConditional   case match
    syn keyword pyRepeat        for while
    syn keyword pyOperator      and in is not or
    syn keyword pyException     except finally raise try
    syn keyword pyInclude       from import
    syn keyword pyAsync         async await

" Decorators
    " A dot must be allowed because of @MyClass.myfunc decorators.
    syn   match   pyDecorator       #@#             display   contained
    syn   match   pyDecoratorName   #@\s*\h\%(\w\|\.\)*#   display   contains=pyDecorator

    " matrix
        " exclude the  symbol ¿@¿  from
            " being highlighed as Decorator
            " when used for matrix multiplication
                " https://www.python.org/dev/peps/pep-0465/
                "\ (mnemonic: @ 表示AT m¿AT¿rix)

        "\ 利用syn-transparent配合contains=ALLBUT :   禁止ALLBUT后的syntax group¿入内¿
        "\ hi pyMatrixMultiply显示:
            "pyMatrixMultiply xxx cleared

        " Single line multiplication.
        syn match   pyMatrixMultiply
                    \ #\%(\w\|[])]\)\s*@#
                    \ transparent
                    \ contains=ALLBUT,
                              \pyDecoratorName,
                              \pyDecorator,
                              \pyFunction,
                              \pyDoctestValue

        " Multiplication continued on the next line after backslash.
        syn match   pyMatrixMultiply
                    \ #[^\\]\\\s*\n\%(\s*\.\.\.\s\)\=\s\+@#
                    \ transparent
                    \ contains=ALLBUT,
                              \pyDecoratorName,
                              \pyDecorator,
                              \pyFunction,
                              \pyDoctestValue

        " Multiplication in a parenthesized expression over multiple lines
        " with @ at  the start of each continued line;
        " very similar to decorators.
        syn match   pyMatrixMultiply
            \ "^\s*\%(\%(>>>\|\.\.\.\)\s\+\)\=\zs\%(\h\|\%(\h\|[[(]\).\{-}\%(\w\|[])]\)\)\s*\n\%(\s*\.\.\.\s\)\=\s\+@\%(.\{-}\n\%(\s*\.\.\.\s\)\=\s\+@\)*"
                    \ transparent
                    \ contains=ALLBUT,
                              \pyDecoratorName,
                              \pyDecorator,
                              \pyFunction,
                              \pyDoctestValue

syn match   pyFunction  #\h\w*# display contained

"\ comment
    " 我加了这个:
        syn match pyCmt_delI '\v\zs# = =\ze\p'   contained   conceal
        syn match pyCmt_delI '# *$'          contained   conceal  " 处理一行里只有井号的情况
        " 之前用这2行, 导致2种方式都能匹配这几行python代码,  打架了 所以无法封印?
            " syn match pyCmt_delI '\v%(^\s*\zs# )'   contained   conceal
            " syn match pyCmt_delI '\v%(\p  \zs# )'   contained   conceal
                " path = os.path.join(dirpath, filename)
                " # construct the source URL from the PDF URL
                " source_url = self.pdf_url.replace('/pdf/', '/src/')

    syn match   pyComment
                  \ "#.*$"
                  \ contains=pyTodo,
                    \@Spell,
                    \@In_fancY,
                    \pyCmt_delI,
                    \pyMath_conceal,
                    "\ 加这些 导致comment里太多高亮:
                    "\ \pyRawStr,
                    "\ \pyStr,
                    "\ \In_Double_QuotE,
                    "\ \In_Single_QuotE

        syn keyword pyTodo    FIXME NOTE NOTES TODO XXX contained

    " pyStr
        syn region  pyStr
                    \ matchgroup=pyQuotes concealends
                    \ start=#\v[uU]=\z(['"])#
                       \ skip=#\v\\\\|\\\z1#
                         "\ skip掉类似\\
                    \ end=#\z1#
                    \ contains=pyEscape,Single_quotE,@Spell
                    \ oneline
                    "\ 加oneline对付:
                        "\ /home/wf/dotF/cfg/pudb/wf_pudb_theme.py里的¿'s¿
                        "\ #   'default' (use the terminal's default foreground),


        hi pyF_Var gui=underline
        "\ hi pyF_Var gui=underline guifg=445500  不生效
        syn match pyF_Var  #\v\{\i.{-}}#  contained containedin=pyF_Str

        hi link  pyF_Str String
        "\ hi pyF_Str guibg=ff0000 guifg=ff0000 gui=none
              "\ 为啥不生效?
        syn region  pyF_Str
                    \ matchgroup=pyQuotes concealends
                    \ start=#\vf\z(['"])#
                       \ skip=#\v\\\\|\\\z1#
                         "\ skip掉类似\\
                    \ end=#\z1#
                    \ contains=pyEscape,Single_quotE,pyF_var,@Spell
                    \ oneline
                    "\ 加oneline对付:
                        "\ /home/wf/dotF/cfg/pudb/wf_pudb_theme.py里的¿'s¿
                        "\ #   'default' (use the terminal's default foreground),



                " 和下面那个 同缩进的block 都表示三引号
                syn region  pyStr
                            \ start=#\v[uU]=\z('''|""")#
                                \ skip=#\\["']#
                            \ end="\z1"
                            \ keepend
                                \ contains=pyEscape,
                                \pySpaceError,
                                \pyDoctest,
                                \@Spell,
                                \@In_fancY

    " pyRawStr
        syn region  pyRawStr
                        \ matchgroup=pyQuotes concealends
                        \ start=#\v[uU]=[rR]\z(['"])#
                            \ skip=#\v\\\\|\\\z1#
                        \ end=#\z1#
                        \ contains=@Spell

                syn region  pyRawStr
                    \ start=#\v[uU]=[rR]\z('''|""")#
                    \ end="\z1" keepend
                    \ contains=pySpaceError,pyDoctest,@Spell,@In_fancY
                            " keepend: 尽早end the region



    syn match   pyEscape    #\\[abfnrtv'"\\]# contained
    syn match   pyEscape    "\\\o\{1,3}" contained
    syn match   pyEscape    "\\x\x\{2}" contained
    syn match   pyEscape    "\%(\\u\x\{4}\|\\U\x\{8}\)" contained
    " Python allows case-insensitive Unicode IDs: http://www.unicode.org/charts/
    syn match   pyEscape    "\\N{\a\+\%(\s\a\+\)*}" contained
    syn match   pyEscape    "\\$"

    " 隐藏docstring两头的三引号
        hi link pyIn_3x2_quoteS Comment  "\ 被TSString覆盖, 显示string的颜色
        syn match   pyQuotes_3x2 /"""/       contained conceal   containedin=pyIn_3x2_quoteS
        syn region  pyIn_3x2_quoteS  start=/"""/   end=/"""/ keepend  contains=@In_fancY
        syn match   pyQuotes_3x2 /r"""/       contained conceal   containedin=pyIn_3x2_quoteS
        syn region  pyIn_3x2_quoteS  start=/r"""/   end=/"""/ keepend  contains=@In_fancY
                "\ concealends 加不加都一样, 不能少了上面那行

        hi link pyIn_3x2_quoteS_space Comment
        syn match   pyQuotes_space_3x2 /""" /       contained conceal   containedin=pyIn_3x2_quoteS_space
        syn region  pyIn_3x2_quoteS_space  start=/""" /  end=/"""/ keepend  contains=@In_fancY
        syn match   pyQuotes_space_3x2 /r""" /       contained conceal   containedin=pyIn_3x2_quoteS_space
        syn region  pyIn_3x2_quoteS_space  start=/r""" /  end=/"""/ keepend  contains=@In_fancY




        " Triple-quoted strings can contain doctests.
            " 几种dostring用法:
                "  """docstrings"""
                " u"""Unicode triple-quoted strings"""
                " r"""raw, can handle backslashes  """
               " ur"""u和r可以一起用吧"""

            "\ 另外,string in single quotes, double quotes, and triple-double quotes
               " can all be used as docstring
                   " (https://hg.python.org/cpython/file/db9fe49069ed/Lib/collections/abc.py#l234)

               "\ 这样不行?  ''' A docstring'''
                    "\ syn match  Triple1quoteS /'''/          contained conceal   containedin=pyIn_3x2_quoteS


" number
    " It is very important to understand all details before changing the  regular expressions below or their order.
    " The word boundaries are *not* the floating-point number boundaries
    " because of a possible leading or trailing decimal point.
    " The expressions below ensure that all valid number literals are
    " highlighted, and invalid number literals are not.  For example,
    "
    " - a decimal point in '4.' at the end of a line is highlighted,
    " - a second dot in 1.0.0 is not highlighted,
    " - 08 is not highlighted,
    " - 08e0 or 08j are highlighted,
    "
    " and so on, as specified in the 'Python Language Reference'.
    " https://docs.python.org/reference/lexical_analysis.html#numeric-literals
    if !exists("python_no_number_highlight")
        " numbers (including longs and complex)
        syn match   pyNumber    "\<0[oO]\=\o\+[Ll]\=\>"
        syn match   pyNumber    "\<0[xX]\x\+[Ll]\=\>"
        syn match   pyNumber    "\<0[bB][01]\+[Ll]\=\>"
        syn match   pyNumber    "\<\%([1-9]\d*\|0\)[Ll]\=\>"
        syn match   pyNumber    "\<\d\+[jJ]\>"
        syn match   pyNumber    "\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
        syn match   pyNumber
        \ "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
        syn match   pyNumber
        \ "\%(^\|\W\)\zs\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"
    endif

" builtin
    " Group the built-ins in the order in the 'Python Library Reference' for
    " easier comparison.
    " https://docs.python.org/library/constants.html
    " http://docs.python.org/library/functions.html
    " Python built-in functions are in alphabetical order.
    "
    " The list can be checked using:
    "
    " python3 -c 'import builtins, pprint; pprint.pprint(dir(builtins), compact=True)'
    "
    " The constants added by the `site` module are not listed below because they
    " should not be used in programs, only in interactive interpreter.
    " Similarly for some other attributes and functions `__`-enclosed from the
    " output of the above command.
    "
    if !exists("python_no_builtin_highlight")
        " built-in constants
        syn keyword pyBuiltin   False True None
            " 'False', 'True', and 'None' are also ¿reserved¿ words in Python 3
        syn keyword pyBuiltin   NotImplemented Ellipsis __debug__
        " constants added by the `site` module
        syn keyword pyBuiltin   quit exit copyright credits license
        " built-in functions
        syn keyword pyBuiltin
                        \ abs
                        \ all
                        \ any
                        \ ascii
                        \ bin
                        \ bool
                        \ breakpoint
                        \ bytearray
                        \ bytes
                        \ callable
                        \ chr
                        \ classmethod
                        \ compile
                        \ complex
                        \ delattr
                        \ dict
                        \ dir
                        \ divmod
                        \ enumerate
                        \ eval
                        \ exec
                        \ filter
                        \ float
                        \ format
                        \ frozenset
                        \ getattr
                        \ globals
                        \ hasattr
                        \ hash
                        \ help
                        \ hex
                        \ id
                        \ input
                        \ int
                        \ isinstance
                        \ issubclass
                        \ iter
                        \ len
                        \ list
                        \ locals
                        \ map
                        \ max
                        \ memoryview
                        \ min
                        \ next
                        \ object
                        \ oct
                        \ open
                        \ ord
                        \ pow
                        \ print
                        \ property
                        \ range
                        \ repr
                        \ reversed
                        \ round
                        \ set
                        \ setattr
                        \ slice
                        \ sorted
                        \ staticmethod
                        \ str
                        \ sum
                        \ super
                        \ tuple
                        \ type
                        \ vars
                        \ zip
                        \ __import__
        " avoid highlighting attributes as builtins
        syn match   pyAttribute
                    \ #\.\h\w*#hs=s+1
                    \ transparent
                    \ contains=ALLBUT,
                              \pyBuiltin,
                              \pyFunction,
                              \pyAsync
    endif


if !exists("python_no_exception_highlight")
    " From the 'Python Library Reference' class hierarchy at the bottom.
    " http://docs.python.org/library/exceptions.html

    " builtin base exceptions (used mostly as base classes for other exceptions)
        syn keyword pyExceptions    BaseException Exception
        syn keyword pyExceptions    ArithmeticError BufferError LookupError
    " builtin exceptions (actually raised)
        syn keyword pyExceptions    AssertionError AttributeError EOFError
        syn keyword pyExceptions    FloatingPointError GeneratorExit ImportError
        syn keyword pyExceptions    IndentationError IndexError KeyError
        syn keyword pyExceptions    KeyboardInterrupt MemoryError
        syn keyword pyExceptions    ModuleNotFoundError NameError
        syn keyword pyExceptions    NotImplementedError OSError OverflowError
        syn keyword pyExceptions    RecursionError ReferenceError RuntimeError
        syn keyword pyExceptions    StopAsyncIteration StopIteration SyntaxError
        syn keyword pyExceptions    SystemError SystemExit TabError TypeError
        syn keyword pyExceptions    UnboundLocalError UnicodeDecodeError
        syn keyword pyExceptions    UnicodeEncodeError UnicodeError
        syn keyword pyExceptions    UnicodeTranslateError ValueError
        syn keyword pyExceptions    ZeroDivisionError
    " builtin exception aliases for OSError
        syn keyword pyExceptions    EnvironmentError IOError WindowsError

    " builtin OS exceptions in Python 3
        syn keyword pyExceptions    BlockingIOError BrokenPipeError
        syn keyword pyExceptions    ChildProcessError ConnectionAbortedError
        syn keyword pyExceptions    ConnectionError ConnectionRefusedError
        syn keyword pyExceptions    ConnectionResetError FileExistsError
        syn keyword pyExceptions    FileNotFoundError InterruptedError
        syn keyword pyExceptions    IsADirectoryError NotADirectoryError
        syn keyword pyExceptions    PermissionError ProcessLookupError TimeoutError

    " builtin warnings
    syn keyword pyExceptions    BytesWarning DeprecationWarning FutureWarning
    syn keyword pyExceptions    ImportWarning PendingDeprecationWarning
    syn keyword pyExceptions    ResourceWarning RuntimeWarning
    syn keyword pyExceptions    SyntaxWarning UnicodeWarning
    syn keyword pyExceptions    UserWarning Warning
endif

if exists( "python_space_error_highlight" )
    " trailing whitespace
    syn match   pySpaceError    display  #\s\+$#  excludenl
    " mixed tabs and spaces
    syn match   pySpaceError    display ' \+\t'
    syn match   pySpaceError    display '\t\+ '
endif

if !exists("python_no_doctest_highlight")
    " Do not spell doctests inside strings.
    " Notice that the end of a string, either ''', or """, will end the contained
    " doctest too.  Thus, we do *not* need to have it as an end pattern.

    if !exists("python_no_doctest_code_highlight")
        syn region pyDoctest
        \ start="^\s*>>>\s" end="^\s*$"
        \ contained contains=ALLBUT,pyDoctest,pyFunction,@Spell
        syn region pyDoctestValue
        \ start=+^\s*\%(>>>\s\|\.\.\.\s\|"""\|'''\)\@!\S\++ end="$"
        \ contained
    else
        syn region pyDoctest
        \ start="^\s*>>>" end="^\s*$"
        \ contained contains=@NoSpell
    endif
endif

" Sync at the beginning of class, function, or method definition.
syn sync match pySync grouphere NONE "^\%(def\|class\)\s\+\h\w*\s*[(:]"

" The default highlight links.  Can be overridden later.
    hi def link pyStatement       Statement
    hi def link pyConditional     Conditional
    hi def link pyRepeat          Repeat
    hi def link pyOperator        Operator
    hi def link pyException       Exception
    hi def link pyInclude         Include
    hi def link pyAsync           Statement
    hi def link pyDecorator       Define
    hi def link pyDecoratorName   Function
    hi def link pyFunction        Function
    hi def link pyComment         Comment
    hi def link pyTodo            Todo

    hi def link pyStr             String
    hi def link pyRawStr          String
    hi def link pyQuotes          String
    hi def link pyTripleQuotes    pyQuotes

    hi def link pyEscape        Special


    if !exists("python_no_number_highlight")
        hi def link pyNumber        Number
    endif
    if !exists("python_no_builtin_highlight")
        hi def link pyBuiltin       Function
    endif
    if !exists("python_no_exception_highlight")
        hi def link pyExceptions        Structure
    endif
    if exists("python_space_error_highlight")
        hi def link pySpaceError        Error
    endif
    if !exists("python_no_doctest_highlight")
        hi def link pyDoctest       Special
        hi def link pyDoctestValue  Define
    endif

    syn match  Py_parse   #parser\.add_argument#  conceal cchar=+

let b:current_syntax = "python"

