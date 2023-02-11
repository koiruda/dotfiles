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

nmap <C-c><C-c> :nohl<CR>
