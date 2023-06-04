set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set number

vnoremap < <gv
vnoremap > >gv

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap n nzz
nnoremap N Nzz

nnoremap h b
nnoremap l w
vnoremap h b
vnoremap l w

nnoremap U <c-r>

nnoremap K 10<Up>
nnoremap J 10<Down>

nnoremap zj zt
nnoremap zk zb

nnoremap QQ ZQ

nmap <C-c><C-c> :nohl<CR>

set clipboard=unnamed

let g:clipboard = {
    \   'name': 'myClipboard',
    \   'copy': {
    \      '+': 'win32yank.exe -i',
    \      '*': 'win32yank.exe -i',
    \    },
    \   'paste': {
    \      '+': 'win32yank.exe -o',
    \      '*': 'win32yank.exe -o',
    \   },
    \   'cache_enabled': 1,
    \ }
