set laststatus=2

" Base color
hi Base guibg=#f0dde6 guifg=#fff0f7

" Mode color
hi Mode guibg=#d46a84 guifg=#fff0f7 gui=bold

" Git color
"hi Git guibg=#292d3e guifg=#929dcb

" Filetype color
hi Filetype guibg=#468dd4 guifg=#fff0f7

" Line Number color
hi LineCol guibg=#d46a84 guifg=#fff0f7 gui=bold

" -----------------------------------------------

" Modes lists
" :h mode() to see all modes
let g:currentmode={
  \ 'n'      : 'Normal ',
  \ 'no'     : 'N·Operator Pending ',
  \ 'v'      : 'Visual ',
  \ 'V'      : 'V·Line ',
  \ '\<C-V>' : 'V·Block ',
  \ 's'      : 'Select ',
  \ 'S'      : 'S·Line ',
  \ '\<C-S>' : 'S·Block ',
  \ 'i'      : 'Insert ',
  \ 'R'      : 'Replace ',
  \ 'Rv'     : 'V·Replace ',
  \ 'c'      : 'Command ',
  \ 'cv'     : 'Vim Ex ',
  \ 'ce'     : 'Ex ',
  \ 'r'      : 'Prompt ',
  \ 'rm'     : 'More ',
  \ 'r?'     : 'Confirm ',
  \ '!'      : 'Shell ',
  \ 't'      : 'Terminal '
  \}

" -----------------------------------------------

" Get current mode
function! ModeCurrent() abort
  let l:modecurrent = mode()
  let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block'))  
  let l:current_status_mode = l:modelist
  return l:current_status_mode
endfunction

" Get current git branch
"function! GitBranch(git)
"  if a:git == ""
"    return '-'
"  else
"    return a:git
"  endif
"endfunction

" Check modified status
function! CheckMod(modi)
  if a:modi == 1
    hi Modi guifg=#fff0f7 guibg=#f55050 gui=bold
    hi Filename guifg=#fff0f7 guibg=#f55050
    return expand('%:F').'*'
  else
    hi Modi guifg=#fff0f7 guibg=#d46a84
    hi Filename guifg=#fff0f7 guibg=#d46a84
    return expand('%:F')
  endif
endfunction

" Get current filetype
function! CheckFT(filetype)
  if a:filetype == ''
    return '-'
  else
    return tolower(a:filetype)
  endif
endfunction

" Get buffer flag
"function! CheckBF(flag)
"  if a:

" We'll use this for the active statusline
function! ActiveLine()
  let statusline = ""
  let statusline .= "%#Base#"

  " Current mode
  let statusline .= "%#Mode# %{ModeCurrent()}"

  " Current git branch
  "let statusline .= "%#Git# %{GitBranch(fugitive#head())} %)"

  " Make the colour highlight normal
  let statusline .= "%#Base#"
  let statusline .= "%="

  " Current modified status and filename
  let statusline .= "%#Modi# %{CheckMod(&modified)} "

  " Current filetype
  let statusline .= "%#Filetype# %{CheckFT(&filetype)} "

  " Current flag
  let statusline .= "%#Filetype# %r\ %w "

  " Current line and column
  let statusline .= "%#LineCol# Ln %l, Col %c "
  return statusline
endfunction

" We'll use this for the inactive statusline
function! InactiveLine()
  let statusline = ""
  let statusline .= "%#Base#"

  " Full path of the file
  let statusline .= "%#Filename# %F "

  return statusline
endfunction

augroup Statusline
  autocmd!
  autocmd WinEnter,Bufenter * setlocal statusline=%!ActiveLine()
  autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveLine()
  autocmd FileType nerdtree setlocal statusline=%!NERDLine()
augroup END
