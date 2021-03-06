filetype on
filetype indent on
filetype plugin on

call pathogen#runtime_append_all_bundles()

set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set laststatus=2
set incsearch
set smarttab
set hlsearch
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
set guioptions-=T " no toolbar
set laststatus=2  " Always show status line.
set number " line numbers
set scrolloff=3 " More context around cursor
set grepprg=ack
set grepformat=%f:%l:%m
set hidden
set ignorecase
set smartcase
set history=1000
set wildmode=list:longest " Shell-like behaviour for command autocompletion
set visualbell
set mousehide
set cf  " Enable error files & error jumping.
set autowrite  " Writes on make/shell commands
set ruler  " Ruler on
set nowrap  " Line wrapping off
set timeoutlen=500
set linebreak

set statusline=
set statusline+=%3.3n\                       " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%1*%m%r%w%0*               " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}%{&bomb?'/bom':''}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=0x%-8B\                      " current char
set statusline+=%-14.(%l/%L,%c%V%)\ %<%P        " offset
set shellcmdflag=-ic

let mapleader=","

" ,W to show trailing whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>W :set nolist!<CR>

" ,h to toggle search result highlighting
:noremap <silent> <leader>h :set hls!<CR>

" ,w to toggle line wrap
:map <silent> <Leader>w :set wrap!<CR>

map <Leader>r :Rake<CR>
map <silent> <Leader>rb :w<CR>:RunAllRubyTests<CR>
map <silent> <Leader>rc :RunRubyFocusedContext<CR>
map <silent> <Leader>rf :RunRubyFocusedUnitTest<CR>

map <silent> <Leader>rr :w<CR>:rubyf %<CR>

let g:speckyQuoteSwitcherKey = "<Leader>s'"
let g:speckySpecSwitcherKey = "<Leader>sx"
let g:speckyRunSpecKey = "<Leader>ss"
let g:speckyWindowType = 1
let g:fuzzy_ignore="input/*"

nmap <silent> <unique> <Leader>. :BufferExplorer<CR>

autocmd FileType make set noexpandtab
autocmd FileType python set noexpandtab
syn on

map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

function! ToggleScratch()
    if expand('%') == g:ScratchBufferName
        quit 
    else 
        Sscratch 
    endif 
endfunction

map <leader>s :call ToggleScratch()<CR>

" Folding settings
set foldmethod=indent "fold based on indent
set foldnestmax=10
set foldlevel=1
set nofoldenable      "dont fold by default

" Jump to last cursor position when opening a file
" Don't do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal g`\""
    endif
  end
endfunction

function! OpenInBrowser(url)
  if has("mac")
    exec '!open '.a:url
  else
    exec '!firefox -new-tab '.a:url.' &'
  endif
endfunction

" Open the Ruby ApiDock page for the word under cursor
function! OpenRubyDoc(keyword)
  let url = 'http://apidock.com/ruby/'.a:keyword
  call OpenInBrowser(url)
endfunction
noremap RB :call OpenRubyDoc(expand('<cword>'))<CR>

" Open the Rails ApiDock page for the word under cursor
function! OpenRailsDoc(keyword)
  let url = 'http://apidock.com/rails/'.a:keyword
  call OpenInBrowser(url)
endfunction

noremap RR :call OpenRailsDoc(expand('<cword>'))<CR>

augroup mkd
  autocmd BufRead *.markdown set ai formatoptions=tcroqn2 comments=n:>
augroup END

nnoremap <silent> <F8> :TlistToggle<CR>

:command Pcd lcd %:p:h

function! EnableBracketCompletion()
  inoremap {      {}<Left>
  inoremap {<CR>  {<CR>}<Esc>O
  inoremap {{     {
  inoremap {}     {}
  inoremap (      ()<Left>
  inoremap (<CR>  (<CR>)<Esc>O
  inoremap ((     (
  inoremap ()     ()
  inoremap [      []<Left>
  inoremap [<CR>  [<CR>]<Esc>O
  inoremap [[     [
  inoremap []     []
  inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
endfunction

function! DisableBracketCompletion()
  iunmap {
  iunmap {<CR>
  iunmap {{
  iunmap {}
  iunmap (
  iunmap (<CR>
  iunmap ((
  iunmap ()
  iunmap [
  iunmap [<CR>
  iunmap [[
  iunmap []
  iunmap <expr> )
endfunction

call EnableBracketCompletion()

nmap <leader>= :ZoomIn<CR>
nmap <leader>- :ZoomOut<CR>

map + :resize +1<CR>
map _ :resize -1<CR>
map < :vertical resize -1<CR>
map > :vertical resize +1<CR>
" Source a local configuration file if available.
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
