set nocompatible

" general setup
set path+=**
set wildmenu

set encoding=utf-8
set termguicolors
" true colors tmux fix
if &term =~# '^screen' || &term =~# '^tmux'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set backspace=2
set laststatus=2

syntax enable
filetype plugin on

" hybrid line numbers
set number relativenumber
set nu rnu

" plugin list
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sainnhe/everforest'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'ziglang/zig.vim'
Plug 'dense-analysis/ale'

call plug#end()

" plugin setup
set background=dark
colorscheme everforest

let g:everforest_background = 'medium'
let g:everforest_enable_italic = 1
let g:everforest_better_performance = 1

let g:airline_theme='google_dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:zig_fmt_autosave = 0

nnoremap <C-t> :NERDTreeRefreshRoot \| NERDTreeToggle<CR>

let NERDTreeShowHidden=1

" write and close current buffer
command! Wq write|bdelete

" switch between buffers without forcing file saving
set hidden

" set incremental search and hightlight
set is hls

" default <leader> is backslesh '\'
nnoremap <leader>c :set operatorfunc=CommentToggle<cr>g@

function! CommentToggle(type)
    let l:comment = '//'
    let l:line = getline(".")

    if a:type ==# 'line'
        if l:line[0:1] ==# l:comment
            " '[ and '] indicates start and end line
            " '!' is used instead of '/' in search pattern
            " see ':h  pattern-delimiter' and
            " https://en.wikipedia.org/wiki/Leaning_toothpick_syndrome
            silent execute "'[,']s!^".l:comment.'\s\?!!g'
        else
            silent execute "'[,']s!^!".l:comment.' !g'
        endif
    endif
endfunction

nnoremap <C-n> :bn<CR>

augroup FixOnSave
    autocmd!
    " strip trailing whitespace on write
    autocmd BufWritePre * :%s/\s\+$//e
augroup END

augroup NewFile
   autocmd!
   " zig template
   autocmd BufNewFile *.zig 0r ~/.vim/templates/zig_main_and_test_temp.zig
augroup END

" ALE fixers
function! FPrettier(buffer) abort
    return {
    \  'command': 'npx prettier --stdin-filepath %s',
    \  'read_temporary_file': 0,
    \  'write_temporary_file': 1,
    \}
endfunction

let g:ale_fixers = {
\   'javascript': [function('FPrettier')],
\   'typescript': [function('FPrettier')],
\   'html': [function('FPrettier')],
\   'css': [function('FPrettier')],
\   'json': [function('FPrettier')],
\}

let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_virtualtext_cursor = 1

" ALE linter
let g:ale_javascript_eslint_executable = 'npx'
let g:ale_javascript_eslint_options = 'eslint'
let g:ale_javascript_eslint_use_global = 0

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'css': ['eslint'],
\}

nmap <silent> [w <Plug>(ale_previous_wrap)
nmap <silent> ]w <Plug>(ale_next_wrap)

