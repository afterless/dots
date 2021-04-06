call plug#begin()

" Themes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'dylanaraps/wal.vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'sainnhe/vim-color-forest-night'
Plug 'arzg/vim-colors-xcode'
Plug 'dracula/vim', { 'as': 'dracula' }

" Enhancements
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'itchyny/lightline.vim'

" Comfort
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
 
" Languages
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-sleuth'
Plug 'sheerun/vim-polyglot'
Plug 'tmhedberg/SimpylFold'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'whonore/Coqtail'

call plug#end()

setlocal spell
set spelllang=en_us

set termguicolors

colorscheme palenight

syntax on
set nowrap
set noshowmode
set tabstop=2 softtabstop=2
set shiftwidth=4
set noswapfile
set expandtab
set number relativenumber
set mouse=a
let mapleader=" "

" Code Folding
set foldenable
set foldmethod=syntax
set foldlevel=99

let g:Hexokinase_highlighters = ['backgroundfull']

"Lightline Config
let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ }
"
"source ~/.config/nvim/statusline.vim

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

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :call <SID>show_documentation()<CR>

" NERD Tree config
map <Leader>n :NERDTreeToggle<CR>

" Window hopping
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-o> <C-w>o
nnoremap <C-s> <C-w>s
nnoremap <C-v> <C-w>v

" Emmet config
let g:user_emmet_leader_key='\'

if executable("python3")
  " get local python from $PATH (virtualenv/anaconda or system python)
  let s:python3_local = substitute(system("which python3"), '\n\+$', '', '')

  function! Python3_determine_pip_options()
    let l:pip_options = '--upgrade '
    if empty(substitute(system("python3 -c 'import site; print(site.getusersitepackages())' 2>/dev/null"), '\n\+$', '', ''))
      " virtualenv pythons may not have site-packages, hence no 'pip -user'
      let l:pip_options = '--upgrade '
    endif
    return l:pip_options
  endfunction

  " Detect whether neovim package is installed; if not, automatically install it
  " Since checking pynvim is slow (~200ms), it should be executed after vim init is done.
  call timer_start(0, { -> s:autoinstall_pynvim() })
  function! s:autoinstall_pynvim()
    let s:python3_neovim_path = substitute(system("python3 -c 'import pynvim; print(pynvim.__path__)' 2>/dev/null"), '\n\+$', '', '')
    if empty(s:python3_neovim_path)
      " auto-install 'neovim' python package for the current python3 (virtualenv, anaconda, or system-wide)
      let s:pip_options = Python3_determine_pip_options()
      execute ("!" . s:python3_local . " -m pip install " . s:pip_options . " pynvim")
      if v:shell_error != 0
        call s:show_warning_message('ErrorMsg', "Installation of pynvim failed. Python-based features may not work.")
      endif
    endif
  endfunction
  
 " Assuming that pynvim package is available (or will be installed later), use it as a host python3
  let g:python3_host_prog = s:python3_local
else
  echoerr "python3 is not found on your system. Most features are disabled."
  let s:python3_local = ''
endif

" Misc. Below
vmap <Tab> >gv
vmap <S-Tab> <gv
inoremap jk <Esc>
vnoremap <A-[> <Esc>
nmap <C-=> <C-^>

" Use clipboard as default register
set clipboard+=unnamedplus

" Shortcut to use blackhole register by default
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X

"Shortcut to use clipboard with <leader>
nnoremap <leader>d d
vnoremap <leader>d d
nnoremap <leader>D D
vnoremap <leader>D D
nnoremap <leader>c c
vnoremap <leader>c c
nnoremap <leader>C C
vnoremap <leader>C C
nnoremap <leader>x x
vnoremap <leader>x x
nnoremap <leader>X X
vnoremap <leader>X Xj

"Coqtail settings
let g:coqtail_nomap = 1
nmap <leader>cc <Plug>CoqStart
nmap <leader>cq <Plug>CoqStop
nmap <leader>ci <Plug>CoqInterrupt
nmap <leader>cj <Plug>CoqNext
nmap <leader>ck <Plug>CoqUndo
nmap <leader>cl <Plug>CoqToLine
nmap <leader>cT <Plug>CoqToTop
nmap <leader>cG <Plug>CoqJumpToEnd
nmap <leader>cg <Plug>CoqGototoDef[!]<arg>
nmap <leader>ch <Plug>Coq Check
nmap <leader>G] <Plug>CoqGoToGoalNext!
nmap <leader>G[ <Plug>CoqGoToGoalPrev!
