unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

let s:darwin = has('mac')

silent! if plug#begin('~/.vim/plugged')

if !s:darwin
  let $GIT_SSL_NO_VERIFY = 'true'
endif

Plug 'junegunn/seoul256.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
if s:darwin
  Plug 'junegunn/vim-xmark'
endif

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --gocode-completer
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp'], 'do': function('BuildYCM') }
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'rust-lang/rust.vim'

call plug#end()
endif

filetype plugin indent on
syntax on

set encoding=utf-8
set number
set cursorline
set autoindent
set smartindent
set autochdir
set hlsearch
set incsearch
set mouse=a
set backspace=indent,eol,start
set wildmenu
set wildignorecase
set whichwrap+=<,>,[,]
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set laststatus=2
set list
set listchars=tab:>·,trail:·

set background=dark
let g:seoul256_background = 233
silent! colo seoul256

autocmd FileType gitcommit set textwidth=72
set hidden

" ctags
set tags=tags;/

let maplocalleader = "\\"

noremap <silent><leader>; :nohlsearch<cr>
      \:syntax sync fromstart<cr>
      \<c-l>

map <Tab> <C-W>W:cd %:p:h<CR>:<CR>

set foldmethod=indent
set foldnestmax=2
nnoremap <space> za
vnoremap <space> zf

vnoremap . :norm.<CR>

" fzf
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
nnoremap <silent> <Leader>f :Rg<CR>

nnoremap <Leader>t :TagbarToggle<CR>

autocmd FileType python map <buffer> <leader>x :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <leader>x <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
let g:python_recommended_style = 0
au Filetype python setlocal ts=2 sts=0 sw=2

let g:ycm_clangd_binary_path = "/opt/homebrew/opt/llvm/bin/clangd"
"let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_global_extra_conf.py'
let g:ycm_max_diagnostics_to_display = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_confirm_extra_conf = 1

nnoremap <leader>gt :YcmCompleter GoTo<CR>
nnoremap <leader>fi :YcmCompleter FixIt<CR>
nnoremap <leader>gd :YcmCompleter GetDoc<CR>
nnoremap <leader>gtp :YcmCompleter GetType<CR>
nnoremap <leader>gp :YcmCompleter GetParent<CR>
nnoremap <leader>gti :YcmCompleter GoToInclude<CR>
nnoremap <leader>gdf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gdc :YcmCompleter GoToDeclaration<CR>

autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.hh,*cc YcmCompleter Format
