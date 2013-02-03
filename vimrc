" pathogen
execute pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" swap and backup files
set backupdir=/Users/orenshklarsky/Documents/auto_saves_and_baks,.,/tmp
set directory=.,/Users/orenshklarsky/Documents/auto_saves_and_baks,/tmp

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

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set mousehide
  
  set background=dark
  let colors_name = "mymacvim"
endif

" set <Leader> to ,
let mapleader = ","

" try no arrows for a while
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" editing and sourcing .vimrc
nmap <silent> <leader>ev :vsp $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

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
inoremap <expr> <Tab> strpart(getline('.'), col('.')-1, 1) == ")" ? 
                                                      \"\<Right>" : "\<Tab>"

inoremap (<CR> (<Enter>)<Esc>O
inoremap ((   (
inoremap ()   ()

" Square brackets autocomplete
inoremap [    []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap [<CR> [<Enter>]<Esc>O
inoremap [[   [
inoremap []   []

" set colorcolumn to highlight 1st and 81st and onwards columns
let &colorcolumn=join([1] + range(81, 256), ",")
 
" set tex flavour (needed by vim-latex)
let g:tex_flavor='latex'

" view pdf using default viewer"
let g:Tex_ViewRuleComplete_pdf = 'open $*.pdf'

" remap command-T keys
let g:CommandTAcceptSelectionMap = '<C-CR>'
let g:CommandTAcceptSelectionSplitMap = '<S-C-CR>'
let g:CommandTAcceptSelectionVSplitMap = '<CR>'

" remap UltiSnips keys
let g:UltiSnipsExpandTrigger = '<A-Tab>'
let g:UltiSnipsJumpForwardTrigger = '<A-Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-A-Tab>'
let g:UltiSnipsListSnippets = '<C-j>'
let g:UltiSnipsEditSplit = 'vertical'

" make two new lines and move cursor up one in normal mode
nmap <Leader>o o<Enter><Esc>ki

" Underline the current line with dashes in normal mode
nnoremap <F5> yyp<c-v>$r-
"
" Underline the current line with equals in insert mode
inoremap <F5> <Esc>yyp<c-v>$r-A
" Underline the current line with equals in normal mode
nnoremap <F6> yyp<c-v>$r=

" Underline the current line with dashes in insert mode
inoremap <F6> <Esc>yyp<c-v>$r=A

" make switching through splits more like tabbing
nmap <C-Tab> <C-w>w
imap <C-Tab> <Esc><C-w>wi

if has("autocmd")
  
    " clear all autocmds
    autocmd!

    " Make backup of vimrc to dropbox after write. Also make a windows
    " version.
    autocmd BufWritePost .vimrc w! /Users/orenshklarsky/Dropbox
                                                       \/vimfiles/nix/.vimrc
    autocmd BufWritePost .vimrc w! /Users/orenshklarsky/Dropbox
                                                       \/vimfiles/Windows/_vimrc

    " Automatic window resizing when external window size changes
    autocmd VimResized * :wincmd =

    " For text and rst files, set 'textwidth' to 78.  
    autocmd FileType text setlocal textwidth=80

    autocmd FileType rst setlocal textwidth=80
    autocmd FileType rst imap <Leader><Leader>j .. code-block:: 
                                                \java<Esc>o<Esc>o<Tab><Tab>

    " Shortcuts for cmpt166 website
    " Compile and open locally.
    autocmd FileType rst nmap <C-r> :!/Users/orenshklarsky/Dropbox/SFU/Teaching
                                      \/CMPT_166_Spring_2013/Website_Source
                                      \/scripts/compAndOpen %<Enter>
    
    autocmd FileType rst imap <C-r> <Esc>:w<Enter>:!/Users/orenshklarsky/Dropbox
                                      \/SFU/Teaching
                                      \/CMPT_166_Spring_2013/Website_Source
                                      \/scripts/compAndOpen %<Enter>i

    " Compile and push changes to website.
    autocmd FileType rst nmap <C-p> :!/Users/orenshklarsky/Dropbox/SFU/Teaching
                                      \/CMPT_166_Spring_2013/Website_Source
                                      \/scripts/push %<Enter><Enter>
    
    autocmd BufNewFile,BufRead *.pde nmap <C-R> :w<Enter> 
                                    \:!/Users/orenshklarsky/Dropbox/SFU/Teaching
                                    \/CMPT_166_Spring_2013/Website_Source
                                    \/scripts/loadFileAndRun '%'<Enter><Enter>
    autocmd BufNewFile,BufRead *.pde imap <C-R> <Esc>:w<Enter> 
                                    \:!/Users/orenshklarsky/Dropbox/SFU/Teaching
                                    \/CMPT_166_Spring_2013/Website_Source
                                    \/scripts/loadFileAndRun '%'<Enter><Enter>i

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.

    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
        \ endif

endif " has("autocmd")

"==================================================
" End of stuff added by me
"================================================== 

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on
