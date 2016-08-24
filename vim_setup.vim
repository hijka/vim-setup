" VimPlug
call plug#begin('~/.vim/plugged')

Plug 'ervandew/supertab'									" Tab completion
Plug 'tpope/vim-surround'									" Modifying surroundings
Plug 'easymotion/vim-easymotion'					" Easier movements
Plug 'raimondi/delimitmate'								" Close brackets/quotes
Plug 'altercation/vim-colors-solarized'		" Solarized colorscheme
Plug 'scrooloose/nerdtree'								" File navigator bar
Plug 'bling/vim-airline'									" Status line
Plug 'morhetz/gruvbox'										" Gruvbox colorscheme
Plug 'tpope/vim-fugitive' 								" Git wrapper
" Plug 'airblade/vim-gitgutter' 						" Git gutter
Plug 'godlygeek/tabular' 									" Easy tab alignment
Plug 'nathanaelkane/vim-indent-guides' 		" Ident guides 

call plug#end()


command! Wrap :set tw=80 | :normal gggqG
command! Wrap200 :set tw=200 | :normal gggqG
command! Wrap132 :set tw=132 | :normal gggqG


" Configuration Variables
	set ts=2                " Default tabstop
	set shiftwidth=2        " Set default tab width to 2
	set bs=indent,eol,start " Allow backspacing over EVERYTHING in insert mode
	set ww=[,],<,>,h,l,b,s  " Allow movement commands to wrap
	set scrolljump=8        " Jump 8 lines at a time when scrolling
	set scrolloff=2         " Show two lines above/below cursor
	set autowrite           " Write buffer when switching (e.g. :make)
	set ruler               " Show line,column numbers
	set hlsearch            " Highlight search terms
	set laststatus=2        " Yeah status line!
	filetype indent on      " Indent properly
	syntax on               " Turn on syntax coloring for color terminals
	set viminfo='100,f1     " Save marks for the last 100 files
	set number              " Show line numbers
	" set showmatch           " Cause cursor to briefly jump to a brace/parentheses/bracket's match
	set incsearch           " Search while you type
	set ignorecase          " For making searching case insensitive
	set smartcase           " For making searching with capitalized letters case sensitive
	set autoindent          " autoindent when possible
	set smartindent         " Do it smartly
	set foldenable          " auto fold code
	set gdefault            " the /g flag on :s substitutions by default
	set wildmenu            " Use builtin wildmenu function
	set wm=2                " Set automatic word-wrapping
	set splitbelow          " Set new split below
	set splitright          " Set new split right
	set mouse=c 						" Remove mouse control

" Visual shifting (does not exit Visual Mode)
	vnoremap < <gv
	vnoremap > >gv

" Remap normal mode mapping
	nnoremap j k
	nnoremap k j
	nnoremap <C-H> <C-W><C-H>
	nnoremap <C-L> <C-W><C-L>
	nnoremap <Leader>h ^
	nnoremap <Leader>l $

" Remap visual mode mapping
	vnoremap j k
	vnoremap k j
	vnoremap <Leader>h ^
	vnoremap <Leader>l $

" Remap leader key
	nnoremap <SPACE> <Nop>
	let mapleader = "\<Space>"

" Remove highlight
	map <Leader><Leader>h :noh<CR>

" Custom moves
	map \4 <C-D>
	map \3 <C-U>

" For when you forget to sudo, really write to the file
	cmap w!! w !sudo tee % > /dev/null

" Make the following paragraph text width apart
	nnoremap Q gq}

" File Specific settings
	autocmd BufRead,BufNewFile *.txt,README,TODO,CHANGELOG,NOTES
		\ setlocal autoindent expandtab tabstop=8 softtabstop=2 shiftwidth=2
		\ textwidth=76 wrap formatoptions=tcqn
		\ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>

" For programming languages using a semi colon at the end of statement.
	autocmd FileType c,cpp,css,java,javascript,perl,php
		\ nmap <silent> <Leader>; :call <SID>appendSemiColon()<cr>

" save sessions with .vis extension
	map <leader>b :mksession!  session.vis<CR>

" automatically source vim sessions so I can open them with the finder
	au BufRead *.vis so %

" Automatically change to the current directory that the file is located in.
	autocmd BufEnter * silent! lcd %:p:h

" Source vimrc file after saving it
	if has("autocmd")
		autocmd! bufwritepost .vimrc source $MYVIMRC
	endif

" Type \v for easy access to vimrc editting
	nmap <leader>v :tabedit $MYVIMRC<CR>

" Set colorscheme
	set background=dark
	colorscheme gruvbox

" Enable cursor to be restored when entering vim
	autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") |
		\   exe "normal! g`\"" |
		\ endif

" Nerd Tree
	" autocmd vimenter * NERDTree 							" Auto loads NERDTree
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	map <C-n> :NERDTreeToggle<CR>

" Reload vimrc in vim
	map <leader>s :source ~/.vimrc<CR>

" Airline colorscheme
	let g:airline_powerline_fonts = 1
	let g:airline_theme='gruvbox'

" Fix font
	if has("gui_macvim")
		set guifont=Menlo
	elseif has("gui_running")
		set guifont=Consolas
	endif

" Indent guide configs
	let g:indent_guides_start_level=2
	let g:indent_guides_guide_size=1

" Easy motion configurations
	" Move to line
	map <Leader><Leader><Enter> <Plug>(easymotion-bd-jk)
	nmap <Leader><Leader><Enter> <Plug>(easymotion-overwin-line)

	" <Leader>f{char} to move to {char}
	map  <Leader><Leader>f <Plug>(easymotion-bd-f)
	nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)

	" Move to word
	map  <Leader><Leader>w <Plug>(easymotion-bd-w)
	nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

" Putty Colorscheme
    if &term =~ "xterm"
        " 256 colors
        let &t_Co = 256
        " restore screen after quitting
        let &t_ti = "\<Esc>7\<Esc>[r\<Esc>[?47h"
        let &t_te = "\<Esc>[?47l\<Esc>8"
        if has("terminfo")
            let &t_Sf = "\<Esc>[3%p1%dm"
            let &t_Sb = "\<Esc>[4%p1%dm"
      else
           let &t_Sf = "\<Esc>[3%dm"
           let &t_Sb = "\<Esc>[4%dm"
       endif
    endif
