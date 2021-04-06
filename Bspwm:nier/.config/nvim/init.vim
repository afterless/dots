call plug#begin()

" Themes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'morhetz/gruvbox'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'sainnhe/vim-color-forest-night'
Plug 'arzg/vim-colors-xcode'
Plug 'dracula/vim', { 'as': 'dracula' }

" Enhancements
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Comfort
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
 
" Languages
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tmhedberg/SimpylFold'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

call plug#end()

setlocal spell
set spelllang=en_us
set termguicolors

colorscheme palenight 

syntax on
set nowrap
set noshowmode
set tabstop=2
set shiftwidth=2
set expandtab
set number relativenumber
set mouse=a
let mapleader=" "

" Code Folding
set foldenable
set foldmethod=syntax
set foldlevel=99

" Airline Config
let g:airline_powerline_fonts = 1
let g:airline_theme='wombat'
hi! Normal ctermbg=NONE guibg=NONE

" COC Settings
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-N>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" NERD Tree config
map <Leader>n :NERDTreeToggle<CR>

" Terminal config
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <Leader>t :call TermToggle(12)<CR>
tnoremap <Leader>t <C-\><C-n>:call TermToggle(12)<CR>

tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

" Window hopping
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Emmet config
let g:user_emmet_leader_key='\'
