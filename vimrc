"Initialize pathogen
call pathogen#infect()

    set background=light
    colorscheme desert
    call togglebg#map("<F5>")

"Always display statusline
set laststatus=2
if has("unix")
    "Load the powerline plugin
    set runtimepath+=~/.vim/bundle/powerline/powerline/bindings/vim

    if system('uname') =~ 'Darwin'
        set guifont=Menlo\ Regular\ for\ Powerline:h14
    else
        set guifont=Ubuntu\ Mono\ 12
    endif
elseif has("win32")
    "make powerline display special characters correctly
    set encoding=utf-8
    source $VIM/_vimrc
    "Fix for fugitive Gdiff E302 error
    set directory+=,~/tmp,$TMP
    if has("gui_win32") || has("gui_win32s")
        "Load the powerline plugin
        set runtimepath+=~/vimfiles/bundle/powerline/powerline/bindings/vim
        set guifont=Inconsolata\ for\ Powerline:h12,Fixedsys:h12,Consolas:h12
    endif
endif

"Enable filetype plugin
filetype plugin on
syntax on

"Auto clean fugitive buffers
if has("autocmd")
    autocmd BufReadPost fugitive://* set bufhidden=delete
endif

"Add command to get Quickfix file list
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

"mappings
map ,pt  <Esc>:%! perltidy<CR>
map ,ptv <Esc>:'<,'>! perltidy<CR>
map ,t   <Esc>:!prove -v %<CR>
nmap ,v :tabedit $MYVIMRC<CR>
nmap ,q :!perl %<CR>
nmap ,a :!python %<CR>

" Pytest
nmap <silent>,f <Esc>:Pytest file<CR>
nmap <silent>,c <Esc>:Pytest class<CR>
nmap <silent>,m <Esc>:Pytest method<CR>
set expandtab
set shiftwidth=2
set autoindent
set smartindent
