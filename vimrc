filetype on
filetype indent on
filetype plugin on
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

let mapleader=","

" ,W to show trailing whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>W :set nolist!<CR>

" ,h to toggle search result highlighting
:noremap <silent> <leader>h :set hls!<CR>

" ,w to toggle line wrap
:map <silent> <Leader>w :set wrap!<CR>

map <Leader>r :Rake<CR>
map <silent> <Leader>rb :RunAllRubyTests<CR>
map <silent> <Leader>rc :RunRubyFocusedContext<CR>
map <silent> <Leader>rf :RunRubyFocusedUnitTest<CR>

map <silent> <Leader>rr :w<CR>:rubyf %<CR>

let g:speckyQuoteSwitcherKey = "<Leader>s'"
let g:speckySpecSwitcherKey = "<Leader>sx"
let g:speckyRunSpecKey = "<Leader>ss"
let g:speckyWindowType = 1

nmap <silent> <unique> <Leader>. :BufExplorer<CR>

autocmd FileType make set noexpandtab
autocmd FileType python set noexpandtab
syn on

let g:fuzzy_ignore = "*.log"
let g:fuzzy_matching_limit = 70

map <leader>t :FuzzyFinderTextMate<CR>
map <leader>b :FuzzyFinderBuffer<CR>

map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

map + :resize +1<CR>
map _ :resize -1<CR>
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
set foldnestmax=3     "deepest fold is 3 levels
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

" Source a local configuration file if available.
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
