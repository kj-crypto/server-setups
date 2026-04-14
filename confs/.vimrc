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

function! PrettierFormat()
    let l:view = winsaveview()
    let l:old_shortmess = &shortmess
    set shortmess+=aF
    silent! %!npx prettier --stdin-filepath %
    let &shortmess = l:old_shortmess
    call winrestview(l:view)
endfunction

augroup FixOnSave
    autocmd!
    " strip trailing whitespace on write
    autocmd BufWritePre * :%s/\s\+$//e
    " run prettier
    autocmd BufWritePost *.js,*.ts,*.json call PrettierFormat()
augroup END

augroup NewFile
   " zig template
   autocmd BufNewFile *.zig 0r ~/.vim/templates/zig_main_and_test_temp.zig
augroup END

