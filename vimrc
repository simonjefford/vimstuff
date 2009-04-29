let mapleader=","
set smartindent
set tabstop=2
set shiftwidth=4
set expandtab
set laststatus=2
set incsearch
set smarttab
set hlsearch

autocmd FileType make set noexpandtab
autocmd FileType python set noexpandtab
syn on
set grepprg=ack
set grepformat=%f:%l:%m

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
