" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                pathogen                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()
call pathogen#helptags()

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" swap and backup files. Should update this to deal with other opts
set backupdir=/Users/orenshklarsky/Documents/auto_saves_and_baks,.,/tmp
set directory=.,/Users/orenshklarsky/Documents/auto_saves_and_baks,/tmp

" General sets
set guioptions-=rL          " don't show scrollbars
set timeoutlen=500
set wildmenu               " use wild menu for command completion
set wildmode=longest:full
set list                   " Show unprintable characters (space, tab,...)
set listchars=tab:▻▻

set completeopt=longest    " complete options.
set completeopt+=menuone
set completeopt+=preview

set laststatus=2           " always show status line
set cursorline             " highlight the cursor line
set scrolloff=3            " min number of screen lines to keep around cursor
set ignorecase             " ignore case while searching
set smartcase              " unless search term has capitals
set smartindent
set number
set expandtab
set shiftwidth=4
set tabstop=4
set ruler                   " show the cursor position
set showcmd
set incsearch               " do incremental search

set grepprg=grep\ -nH\ $*   " grep always generates file name
set spl=en_ca spell
set ch=2                    " set command line height to 2
set splitright              " when splitting add new window to the right
set nowrap                  " don't wrap lines when they go off the edge
set clipboard+=unnamed      " yanks go to the clipboard as well

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                gui stuff                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &t_Co > 2 || has("gui_running")
  " color scheme. molokai sets background=dark. Remember this if you switch.
  "let colors_name = "molokai"

  syntax enable
  set background=dark
  colorscheme solarized

  " set toggle background key for solarized to <F1>
  call togglebg#map("<F1>")

  set hlsearch
  set mousehide

  " Set system specific font
  if has("gui_gtk2")
      :set guifont=Luxi\ Mono\ 12
  elseif has("gui_win32")
      :set guifont=Luxi_Mono:h12:cANSI
  elseif has("gui_macvim")
      :set guifont=Menlo_Bold:h12
  endif
endif

" Have cursor change shape if running from terminal/tmux 
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
elseif &term == "xterm-256color"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<ESC>]50;CursorShape=0\x7"
endif

" set <Leader> to ,
let mapleader = ","

" map ctrl-a to ctrl-w to get me consistent with tmux pane switching
nnoremap <C-a> <C-w>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" unhighlight after search
nnoremap <Leader><space> :noh<CR>

" Less obnoxious end of line motion
nnoremap \ $
vnoremap \ $
onoremap \ $

" Enter command mode using ;
" change forward/backward line searching
nnoremap ' ;
vnoremap ' ;
nnoremap " ,
vnoremap " ,
nnoremap ; :
nnoremap ; :

" open todo file for vim improvements
nnoremap <leader>vtodo :silent !mvim $HOME/.vim/vimprovements.rst<CR>

" better escape
imap jk <esc>
cmap jk <esc>

" try no arrows for a while
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" editing and sourcing .vimrc
nmap <leader>ev :sp $MYVIMRC<CR><C-w>J:resize 10<CR>
nmap <leader>sv :so $MYVIMRC<CR>

" open vertical or horizontal split and switch
nnoremap <leader>v :vne<CR>
nnoremap <leader>h <C-w>n

" rotate windows clockwise, keeping one vertical and the rest horizontal
nnoremap <silent> <leader>r :call CycleWindows()<CR>

" vertical help
cmap vh vert help

" set colorcolumn to highlight 1st and 81st and onwards columns
let &colorcolumn=join([1] + range(80, 256), ",")

" make two new lines and move cursor up one in normal mode
nmap <Leader>o o<Enter><Esc>ki

" delete trailing white space document wide
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR><C-o>

nnoremap <leader>n :call NumberToggle()<cr>

if has("autocmd")

    " clear all autocmds
    autocmd!

    " Type z/ to toggle highlighting on/off.
    nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>

    " save the file on focus lost, entering insert, and 'updatetime'
    " miliseconds after the last time the cursor moved in insert mode
    " (non repeating).
    autocmd FocusLost,InsertLeave,CursorHold,CursorHoldI * :wa

    " make first column a little more visible in solarized dark theme
    autocmd ColorScheme *
        \ if &background=='dark' |
            \ exe "hi! ColorColumn guibg=#005264" |
        \ endif

    " Automatic window resizing when external window size changes
    autocmd VimResized * :wincmd =

    " Don't continue comment when I break line
    autocmd FileType * set formatoptions-=r

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.

    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
        \ endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           rst and text files                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " For text and rst files, set 'textwidth' to 80.
    autocmd FileType text,rst setlocal textwidth=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                rst only                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " tell delimitMate to allow nesting `
    autocmd FileType rst let b:delimitMate_nesting_quotes = ['`']

    " Shortcuts for cmpt166 website
    " Compile and open locally.
    autocmd FileType rst nnoremap <buffer> <D-r> :!/Users/orenshklarsky/Dropbox/
                          \SFU/Teaching/CMPT_166_Spring_2013/
                          \Website_Source/scripts/compAndOpen %<Enter>

    autocmd FileType rst inoremap <buffer> <D-r> <Esc>:w<CR>:!/Users
                                      \/orenshklarsky/Dropbox/SFU/Teaching
                                      \/CMPT_166_Spring_2013/Website_Source
                                      \/scripts/compAndOpen %<Enter>i

    " Compile and push changes to website.
    autocmd FileType rst nnoremap <buffer> <C-p> :!/Users/orenshklarsky/Dropbox/
                                      \SFU/Teaching/CMPT_166_Spring_2013/
                                      \Website_Source/scripts/push %<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Processing files                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " tag processing files as if they were java
    autocmd BufWritePost *.pde :silent !start ctags -R --language-force=java --fields=+iaS .

    autocmd FileType processing nnoremap <buffer> <D-r> :w<CR>:!/Users
                                    \/orenshklarsky/Dropbox/SFU/Teaching
                                    \/CMPT_166_Spring_2013/Website_Source
                                    \/scripts/loadFileAndRun '%'<CR>
    autocmd FileType processing inoremap <buffer> <D-r> <Esc>:w<CR>:!/Users
                                    \/orenshklarsky/Dropbox/SFU/Teaching
                                    \/CMPT_166_Spring_2013/Website_Source
                                    \/scripts/loadFileAndRun '%'<CR>i
    autocmd FileType processing setlocal completefunc=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                tex files                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    autocmd FileType tex setlocal textwidth=80

    autocmd FileType tex inoremap <buffer> <expr> $ strpart(getline('.'), col('.')-1, 1) == "$" ? "\<Right>" : "$"

    augroup keyBindings
        autocmd FileType tex nnoremap <buffer> <D-r> :Latexmk<CR>
        autocmd FileType tex nnoremap <buffer> <leader>v :LatexmkView<CR>
        " <D-m> sets equation env
        autocmd FileType tex inoremap <buffer> <D-m> $$<Esc>i
        " <D-e> emphasizes
        autocmd FileType tex inoremap <buffer> <D-e> \emph{}<Esc>i
    augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 python files                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " tags (commented out b/c trying jedi + tagbar)
    "autocmd BufWritePost *.py :silent !ctags -R --fields=+iaS .

    " run
    autocmd FileType python nnoremap <buffer> <D-r> :w<CR>:!python %<CR>
    autocmd FileType python inoremap <buffer> <D-r> <Esc>:w<CR>:!python %<CR>

    " syntastic checker, ignore some errors.
    autocmd FileType python 
               \ let g:syntastic_python_flake8_args = '--ignore=E203,E302,E127'

endif " has("autocmd")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                latex-suite                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set tex flavour (needed by vim-latex)
"let g:tex_flavor='latex'

" view pdf using default viewer
"let g:Tex_ViewRuleComplete_pdf = 'open $*.pdf'

"" latex jump forward to next marker
"inoremap <C-right> <Plug>IMAP_JumpForward
"nnoremap <C-right> <Plug>IMAP_JumpForward
"xnoremap <C-right> <Plug>IMAP_JumpForward

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                latex-box                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:LatexBox_viewer = "open"
let g:LatexBox_latexmk_options = ""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                supertab                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabClosePreviewOnPopupClose = 1

" If we have an omnifunc, use it. If we don't have omnifunc, but have
" completefunc, use that. No need to set precedence in this case as that is
" the default
if has("autocmd")
    autocmd FileType *
     \  if &omnifunc != '' |
     \      let g:SuperTabDefaultCompletionType = "context" |
     \      let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>" |
     \      let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc'] |
     \  elseif &completefunc != '' |
     \      let g:SuperTabDefaultCompletionType = "context" |
     \      let g:SuperTabContextDefaultCompletionType = "<c-x><c-u>" |
     \  endif
endif " has("autocmd")
let g:SuperTabMappingTabLiteral = "<A-S-Tab>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                commandt                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:CommandTAcceptSelectionMap = '<C-CR>'
let g:CommandTAcceptSelectionSplitMap = '<S-CR>'
let g:CommandTAcceptSelectionVSplitMap = '<CR>'
let g:CommandTMaxHeight = 16
let g:CommandTMinHeight = 16
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                UltiSnips                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" remap UltiSnips keys
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsEditSplit = 'vertical'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                YankRing                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>p :YRShow<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                syntastic                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['python', 'java'],
                           \ 'passive_filetypes': ['rst'] }
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    delimitMate                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let delimitMate_expand_cr = 1

imap <C-g><C-g> <Plug>delimitMateJumpMany
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     tagbar                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F4> :TagbarOpen jfc<CR>
nnoremap <F5> :call MyTagbarToggle()<CR>

" expand the window when in GUI vim (tagbar does the checking)
let g:tagbar_expand = 1

" show tagbar window on the left
let g:tagbar_left = 1

syntax on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Functions                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" toggle between number and relativenumber
function! NumberToggle()
    if (&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

" cycle window positions clockwise
func! CycleWindows()
    let oldWin = winnr() " get current window number
    silent! exe "normal! \<C-w>l"
    let newWin = winnr()
    silent! exe oldWin.'wincmd w'
    if oldWin == newWin  " we were on the right
        silent! exe "normal! \<C-w>h"
    endif
    silent! exe "normal! \<C-w>K\<C-w>r\<C-w>k\<C-w>H"
endfunction

" Closing tagbar when vim window right edge is less than g:tagbar_width
" columns away from right edge of the screen and g:tagbar_expands == 1
" results in the vim window changing its original position. This restores it.
let g:tagbarOpen = 0
let g:winposXY = [0, 0]
func! MyTagbarToggle()
    if g:tagbarOpen == 0
        redir => winposOut
        silent exec 'winpos'
        redir END
        let winposList = split(winposOut)
        let g:winposXY[0] = winposList[3][:-2]
        let g:winposXY[1] = winposList[5][:-2]
    else
        exec 'winpos' . g:winposXY[0] . ' ' . g:winposXY[1]
    endif

    let g:tagbarOpen = 1 - g:tagbarOpen
    silent exec 'TagbarToggle'
endfunc


" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
function! AutoHighlightToggle()
    let @/ = ''
    if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
        setl updatetime=4000
        echo 'Highlight current word: off'
        return 0
    else
        augroup auto_highlight
            au!
            au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
        augroup end
        setl updatetime=500
        echo 'Highlight current word: ON'
        return 1
    endif
endfunction
