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

" Indentation setup
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Plugins with vim-plug
call plug#begin()

" Bracket(s) manipulation
Plug 'tpope/vim-surround'

" Easy batch commenting like Emacs
Plug 'tpope/vim-commentary'

" ParEdit ported to Vim
Plug 'kovisoft/paredit'

" Neovim embedded into a web browser
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()
