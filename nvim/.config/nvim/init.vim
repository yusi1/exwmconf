" Show line numbers
set nu
" Show relative line numbers
set rnu

" Reassign the arrow keys to do nothing while in normal/visual mode
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>

" Quickly insert a newline without entering Insert mode 
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

" OSC52 keybinds
" https://github.com/ojroques/vim-oscyank
" vnoremap <leader>c :OSCYank<CR>
" autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif

" Indentation setup
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Plugins with vim-plug
call plug#begin()

" OSC52 standard support plugin
" copy text from anywhere into the system clipboard
" Plug 'ojroques/vim-oscyank', {'branch': 'main'}

" Activity watcher vim plugin
" Plug 'ActivityWatch/aw-watcher-vim'

" Solarized theme
Plug 'altercation/vim-colors-solarized'

" Align text
Plug 'godlygeek/tabular'

" Bracket(s) manipulation
Plug 'tpope/vim-surround'

" Easy batch commenting like Emacs
Plug 'tpope/vim-commentary'

" Parinfer - a newer and simpler Paredit
Plug 'bhurlow/vim-parinfer'

" " Parinfer - a newer and simpler Paredit
" Plug 'eraserhd/parinfer-rust', {'do':
"         \  'cargo build --release'}

" ParEdit ported to Vim
" Plug 'kovisoft/paredit'

" Neovim embedded into a web browser
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" Vim OneDark theme
Plug 'joshdick/onedark.vim'

" Vim Lightline statusbar
Plug 'itchyny/lightline.vim'

" Vim Fish config syntax highlighting
Plug 'dag/vim-fish'

" Better syntax highlighting
Plug 'sheerun/vim-polyglot'

call plug#end()

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
" if (empty($TMUX))
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
" endif

" Lightline theme
let g:lightline = {
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' },
            \ 'colorscheme': 'onedark',
            \ }

" Theme
set background=dark
" colorscheme onedark
set cursorline
set laststatus=2
let g:onedark_terminal_italics = 1


" Syntax
syntax enable
filetype plugin indent on

" Set up :make to use fish for syntax checking.
compiler fish

" Set this to have long lines wrap inside comments.
setlocal textwidth=79

" Enable folding of block structures in fish.
setlocal foldmethod=expr
