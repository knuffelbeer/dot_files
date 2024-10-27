vim.cmd([[

let g:netrw_winsize = 30
let g:netrw_keepdir = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

function! NetrwMapping()
  nmap <buffer> <TAB> mf
  nmap <buffer> <S-TAB> mF
  nmap <buffer> <Leader><TAB> mu
  nmap <buffer> L <CR>:Lexplore<CR>
  nmap <buffer> <Leader>dd :Lexplore<CR>
endfunction


augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

]])
vim.keymap.set("n", "<leader>pv", ":Ex<CR>")
