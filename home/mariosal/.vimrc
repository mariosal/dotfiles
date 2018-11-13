set nocompatible
filetype plugin indent on
set backspace=indent,eol,start

syntax on
set ruler
set number

" Highlight the screen line of the cursor
set cursorline

" Don't wrap text by default
set nowrap

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Fix motions for wrapped lines
nnoremap j gj
nnoremap k gk

" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-n>"
  endif
endfunction
inoremap <Tab> <C-R>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-P>
