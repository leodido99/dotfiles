"set statusline+=%F " Set file name in status line
set number		" Add line number
set autowrite		" Write buffer on :next, :last etc...
set autoread		" Read file on outside change
set clipboard=unnamed	" Yank to primary clipboard
			" (Requires vim-enhanced vim-X11 on Fedora)
set ttimeoutlen=10	" Lower delay on exit insert mode
set cursorline		" Highlight cursor
set exrc
set secure
set tabstop=8
set softtabstop=8
set shiftwidth=8
set undodir=$HOME/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000
set splitright
set splitbelow
set laststatus=2
set noshowmode		" Hide the default mode text
set incsearch		" Display search results as search string is typed
set ruler		" Show the line and column number of the cursor position
set wildmenu		" Command line completion shows menu
set display+=lastline	" Display as much as possible of the last line in a window
if &listchars ==# 'eol:$' " Change setlist displayed char
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif
if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
set sessionoptions-=options

" Enable pathogen
execute pathogen#infect()

" Handle true colors
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Path for :find
" Zephyr main repo
set path=~/gitrepo/fwv6-main/**

" Color scheme
syntax enable
"colorscheme solarized8
"set background=dark
let g:nord_underline = 1
"let g:nord_italic = 1
"let g:nord_italic_comments = 1
let g:nord_comment_brightness = 15
let g:nord_cursor_line_number_background = 1
colorscheme nord

" Highlight column 80
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray
" Highlight trailing spaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" vim-airline
let g:airline#extensions#tabline#enabled = 1
" Disable branch name
let g:airline#extensions#branch#enabled = 0
" Customize sections
let g:airline_section_y = ""
"let g:airline_theme='solarized'
"let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1

" ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsSnippetDirectories=["/home/lbise/backup_stuff/vim/UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" gutentags
" Exclude build directories
let g:gutentags_ctags_exclude=[ "build" ]
set statusline+=%{gutentags#statusline()}

" Configure make
" Call script and provide current file path
let &makeprg='compile_zephyr %:p:h'

" Session
" Only save buffers on mksession
set sessionoptions=buffers

" Key mappings
let mapleader = " "

if &term =~ '^screen'
" Use cat in tmux to see what codes are produced by the key combination
" tmux will send xterm-style keys when its xterm-keys option is on
execute "set <xUp>=\e[1;*A"
execute "set <xDown>=\e[1;*B"
execute "set <xRight>=\e[1;*C"
execute "set <xLeft>=\e[1;*D"
execute "set <xHome>=\e[1;*H"
execute "set <xEnd>=\e[1;*F"
execute "set <PageUp>=\e[5;*~"
execute "set <PageDown>=\e[6;*~"
execute "set <F1>=\eOP"
execute "set <F2>=\eOQ"
execute "set <F3>=\eOR"
execute "set <F4>=\eOS"
execute "set <xF1>=\eO1;*P"
execute "set <xF2>=\eO1;*Q"
execute "set <xF3>=\eO1;*R"
execute "set <xF4>=\eO1;*S"
execute "set <F5>=\e[15;*~"
execute "set <F6>=\e[17;*~"
execute "set <F7>=\e[18;*~"
execute "set <F8>=\e[19;*~"
execute "set <F9>=\e[20;*~"
execute "set <F10>=\e[21;*~"
execute "set <F11>=\e[23;*~"
execute "set <F12>=\e[24;*~"
endif

" You shall learn using vim properly
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"map <f5> :mksession! ~/.vimsession/lbise.vim<CR>
map <f5> :Obsession ~/.vimsession/lbise.vim<CR>
map <f6> :source ~/.vimsession/lbise.vim<CR>

map <f9> :make<CR>
map <C-f9> :!compile_zephyr %:p:h clean<CR>
map <S-f9> :!compile_zephyr %:p:h distclean<CR>
map <f12> :!run_checkpatch %:p:h<CR>

map <C-Left> :bn<CR>
map <C-Right> :bp<CR>
map <C-h> :bn<CR>
map <C-l> :bp<CR>

" Clear search highlights
nnoremap <silent> <Leader><Esc> <Esc>:nohlsearch<CR><Esc>
" Remove all trailing and leading whitespaces
map <F4> :%s/\s\+$//e<CR>
" Copy/paste to system clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p
