" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" swap and backup files
set backupdir=/Users/orenshklarsky/Documents/auto_saves_and_baks,.,/tmp
set directory=.,/Users/orenshklarsky/Documents/auto_saves_and_baks,/tmp

" General sets
set wildmenu               " use wild menu for command completion
set wildmode=longest:full
set list
set listchars=tab:▻▻

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

" gui stuff
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set mousehide

  " Set system specific font
  if has("gui_gtk2")
      :set guifont=Luxi\ Mono\ 12
  elseif has("gui_win32")
      :set guifont=Luxi_Mono:h12:cANSI
  elseif has("gui_macvim")
      :set guifont=Monaco:h12
  endif

  " color scheme. molokai sets background=dark. Remember this if you switch.
  let colors_name = "my_molokai"
endif

" set <Leader> to ,
let mapleader = ","

" better escape
imap jk <esc>
cmap jj <esc>

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
nmap <leader>ev :vsp $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>

" open vertical or horizontal split and switch
nnoremap <leader>v :vne<CR>
nnoremap <leader>h <C-w>n

" Move through splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" semi-colon command mode
nnoremap ; :

" vertical help
cmap vh vert help

" Braces autocomplete
inoremap {    {}<Left>
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap {<CR> {<CR>}<Esc>O
inoremap {{   {
inoremap {}   {}

" Parentheses autocomplete
inoremap (    ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap (<CR> (<CR>)<Esc>O
inoremap ((   (
inoremap ()   ()

" Square brackets autocomplete
inoremap [    []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap [<CR> [<CR>]<Esc>O<Tab>
inoremap [[   [
inoremap []   []

" set colorcolumn to highlight 1st and 81st and onwards columns
let &colorcolumn=join([1] + range(80, 256), ",")

" make two new lines and move cursor up one in normal mode
nmap <Leader>o o<Enter><Esc>ki

" make switching through splits more like tabbing
nmap <C-Tab> <C-w>w
imap <C-Tab> <Esc><C-w>wi

" delete trailing white space document wide
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" toggle between number and relativenumber
function! NumberToggle()
    if (&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

nnoremap <leader>n :call NumberToggle()<cr>

if has("autocmd")

    " clear all autocmds
    autocmd!

    " save the file on focus lost.
    autocmd FocusLost * :wa

    " Make backup of vimrc to dropbox after write. Also make a windows
    " version.
    autocmd BufWritePost .vimrc w! /Users/orenshklarsky/Dropbox
                                                       \/vimfiles/nix/.vimrc
    autocmd BufWritePost .vimrc w! /Users/orenshklarsky/Dropbox
                                                       \/vimfiles/Windows/_vimrc

    " Automatic window resizing when external window size changes
    autocmd VimResized * :wincmd =

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

    autocmd BufNewFile,BufRead *.pde nnoremap <buffer> <D-r> :w<CR>:!/Users
                                    \/orenshklarsky/Dropbox/SFU/Teaching
                                    \/CMPT_166_Spring_2013/Website_Source
                                    \/scripts/loadFileAndRun '%'<CR>
    autocmd BufNewFile,BufRead *.pde inoremap <buffer> <D-r> <Esc>:w<CR>:!/Users
                                    \/orenshklarsky/Dropbox/SFU/Teaching
                                    \/CMPT_166_Spring_2013/Website_Source
                                    \/scripts/loadFileAndRun '%'<CR>i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 python files                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " run
    autocmd FileType python nnoremap <buffer> <D-r> :w<CR>:!python %<CR>
    autocmd FileType python inoremap <buffer> <D-r> <Esc>:w<CR>:!python %<CR>
endif " has("autocmd")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                pathogen                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()
call pathogen#helptags()

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                supertab                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabMappingTabLiteral = "<A-Tab>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                commandt                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" CommandT options
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
"let g:UltiSnipsJumpForwardTrigger = '<Tab>'
"let g:UltiSnipsJumpBackwardTrigger = '<A-Tab>'
"let g:UltiSnipsListSnippets = '<S-A-Tab>'
let g:UltiSnipsEditSplit = 'vertical'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                YankRing                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                syntastic                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['python', 'java'],
                           \ 'passive_filetypes': ['rst'] }
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   stuff put in before I knew anything                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Switch syntax highlighting on
syntax on
