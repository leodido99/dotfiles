"set statusline+=%F " Set file name in status line
set number		" Add line number
set autowrite		" Write buffer on :next, :last etc...
set autoread		" Read file on outside change
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
colorscheme solarized8
set background=dark

" Highlight column 110
set colorcolumn=110
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
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
"let g:airline_powerline_fonts = 1

" ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsSnippetDirectories=["/home/lbise/backup_stuff/vim/UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" ConqueGDB
let g:ConqueGdb_GdbExe = 'arm-zephyr-eabi-gdb'
let g:ConqueGdb_SrcSplit = "left"
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_ReadUnfocused = 1

" gutentags
" Exclude build directories
let g:gutentags_ctags_exclude=[ "build" ]
set statusline+=%{gutentags#statusline()}

" Configure make
" Call script and provide current file path
let &makeprg='~/scripts/compile_zephyr.sh %:p:h'

" Session
" Only save buffers on mksession
set sessionoptions=buffers

" Key mappings
let mapleader = " "

if &term =~ '^screen'
" tmux will send xterm-style keys when its xterm-keys option is on
execute "set <xUp>=\e[1;*A"
execute "set <xDown>=\e[1;*B"
execute "set <xRight>=\e[1;*C"
execute "set <xLeft>=\e[1;*D"
endif

map <C-o> :NERDTreeToggle<CR>

"map <f5> :mksession! ~/.vimsession/lbise.vim<CR>
map <f5> :Obsession ~/.vimsession/lbise.vim<CR>
map <f6> :source ~/.vimsession/lbise.vim<CR>
map <f7> :TagbarToggle<CR>

map <f9> :make<CR>
map <C-f9> :!~/scripts/compile_zephyr.sh %:p:h clean<CR>
map <S-f9> :!~/scripts/compile_zephyr.sh %:p:h distclean<CR>
map <f10> :ConqueGdb -ex "target remote :2331" 
map <C-f10> :ConqueGdb -ex "target remote :2341" 
map <f12> :!~/scripts/run_checkpatch.sh %:p:h<CR>

map <C-Left> :bn<CR>
map <C-Right> :bp<CR>
