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

set cursorline             " highlight the cursor line
set ttyfast                " fast "terminal"
set scrolloff=3        " minimal number of screen lines to keep around cursor
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
nnoremap <leader><space> :noh<cr>

set grepprg=grep\ -nH\ $*   " grep always generates file name
set spl=en_ca spell         
set ch=2                    " set command line height to 2
set splitright              " when splitting add new window to the right
set nowrap                  " don't wrap lines when they go off the edge
set clipboard+=unnamed      " yanks go to the clipboard as well
set hidden                  " the current buffer can be switched without writing

" gui stuff
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set mousehide
  
  set background=dark
  let colors_name = "mymacvim"
endif

" set <Leader> to ,
let mapleader = ","

" better escape
imap jj <esc>
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
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j

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
inoremap <expr> <space> strpart(getline('.'), col('.')-1, 1) == ")" ?
                                                      \ "\<right>" : "\<space>"

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
let &colorcolumn=join([1] + range(81, 256), ",")
 
" make two new lines and move cursor up one in normal mode
nmap <Leader>o o<Enter><Esc>ki

" make switching through splits more like tabbing
nmap <C-Tab> <C-w>w
imap <C-Tab> <Esc><C-w>wi

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
    autocmd FileType rst nmap <buffer> <D-r> :!/Users/orenshklarsky/Dropbox/SFU/
                                  \Teaching/CMPT_166_Spring_2013/Website_Source/
                                  \scripts/compAndOpen %<Enter>
    
    autocmd FileType rst imap <buffer> <D-r> <Esc>:w<CR>:!/Users
                                      \/orenshklarsky/Dropbox/SFU/Teaching
                                      \/CMPT_166_Spring_2013/Website_Source
                                      \/scripts/compAndOpen %<Enter>i

    " Compile and push changes to website.
    autocmd FileType rst nmap <buffer> <C-p> :!/Users/orenshklarsky/Dropbox/SFU
                                      \/Teaching/CMPT_166_Spring_2013/Website_Source
                                      \/scripts/push %<Enter><Enter>
    
    autocmd BufNewFile,BufRead *.pde nmap <buffer> <D-r> :w<CR>:!/Users
                                    \/orenshklarsky/Dropbox/SFU/Teaching
                                    \/CMPT_166_Spring_2013/Website_Source
                                    \/scripts/loadFileAndRun '%'<CR>
    autocmd BufNewFile,BufRead *.pde imap <buffer> <D-r> <Esc>:w<CR>:!/Users
                                    \/orenshklarsky/Dropbox/SFU/Teaching
                                    \/CMPT_166_Spring_2013/Website_Source
                                    \/scripts/loadFileAndRun '%'<CR>i

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
"
"" view pdf using default viewer
"let g:Tex_ViewRuleComplete_pdf = 'open $*.pdf'
"
""" latex jump forward to next marker
""imap <C-right> <Plug>IMAP_JumpForward
""nmap <C-right> <Plug>IMAP_JumpForward
""xmap <C-right> <Plug>IMAP_JumpForward

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                supertab                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                CommandT                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" CommandT options 
let g:CommandTAcceptSelectionMap = '<C-CR>'
let g:CommandTAcceptSelectionSplitMap = '<S-C-CR>'
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
nmap "p :YRShow<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                syntastic                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_check_on_open=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   stuff put in before I knew anything                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Switch syntax highlighting on
syntax on
