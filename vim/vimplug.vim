call plug#begin('~/.vim/plugged')

" Markdown instan preview in web browser
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Bracey live editing html and css
Plug 'turbio/bracey.vim'

" Vim Latex Suite
Plug 'vim-latex/vim-latex'

" Vim emmet
Plug 'mattn/emmet-vim'

" Vim Fugitive
Plug 'tpope/vim-fugitive'

call plug#end()
