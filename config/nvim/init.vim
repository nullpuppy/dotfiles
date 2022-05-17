set nocompatible                " disable compatibility to old-time vi
set showmatch                   " show matching
set ignorecase                  " case insensitive
set mouse=v                     " middle-click paste with
set hlsearch                    " highlight search
set incsearch                   " incremental search
set tabstop=4                   " number of columns occupied by a tab
set softtabstop=4               " see multiple spaces as tabstops so <BS> does the right thing
set expandtab                   " converts tabs to spaces
set shiftwidth=4                " width for autoindents
set autoindent                  " indent a new line the same amount as the line just typed
set copyindent                  " Copy structure of existing line's indent when adding a new line
set preserveindent              " When changing a line's indent, preserve as much of the structure as possible
set number                      " add line numbers
set wildmode=longest,list       " get bash-like tab completions
set cc=120                      " set an 120 column border
filetype plugin indent on       " allow auto-indenting depending on file type
syntax on                       " syntax highlighting
set mouse=a                     " enable mouse click
set clipboard=unnamedplus       " using system clipboard
filetype plugin on
set cursorline                  " highlight current cursorline
set ttyfast                     " Speed up scrolling in vim
set hidden                      " allow hiding buffers with modification
" set spell                     " enable spellcheck
set backspace=indent,eol,start  " intuitive backspacing in insert mode

" Setup python for nvim stuff
let g:python2_host_prog = '$HOME/.venv/py2nvim/bin/python'
let g:python3_host_prog = '$HOME/.venv/py3nvim/bin/python'

" Swap settings {{{
" set noswapfile                " disable creating swap file
set directory=$XDG_CACHE_HOME/nvim/backup,.,~/.local/share/nvim/backup,/tmp
" }}}

" Backup Settings: {{{
" Enable backup files
set backupdir=$XDG_CACHE_HOME/nvim/backup,.,~/.local/share/nvim/backup,/tmp
" Default backupdir
" set backupdir=.,~/.local/share/nvim/backup
set backup

" Ensure we cover all temp files for backup file creation
" if has('macunix')
"     set backupskip+=/private/tmp/*
" endif

" Rename the file to the backup when possible
set backupcopy=auto
" }}}

" Persistent undo
if has('persistent_undo')
    set undofile
    " let &undodir = &backupdir
    set undodir=$XDG_CACHE_HOME/nvim,~/,/tmp
endif

" Theme - Base16 {{{
let base16colorspace=256        " Access colors presnt in 256 colorspace
set background="dark"
colorscheme base16-default-dark
" }}}

" Sudo save!
cnoremap w!! w !sudo tee % >/dev/null<cr>

" Use ag, or ack if available
if executable('ag')
  set grepprg=ag\ -H\ --nocolor\ --nogroup\ --column\ $*
  set grepformat=%f:%l:%c:%m
elseif executable('ack')
  set grepprg=ack\ -H\ --nocolor\ --nogroup\ --column\ $*
  set grepformat=%f:%l:%c:%m
endif

" Airline Config {{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline_powerline_fonts = 1
" }}}

" CtrlSpace Config {{{
let g:CtrlSpaceUseMouseAndArrowsInTerm = 1
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

let g:CtrlSpaceDefaultMappingKey = "<C-space> "
" }}}

" Completions stuff {{{
" Give more space for displaying messages
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=number

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Display completions -- this *might* interfere with ctrlspace above
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" }}}

