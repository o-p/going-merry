"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" 修改前綴鍵 <Leader> 成 comma
let mapleader = ","
let g:mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 上下移動指標時保留 7 行邊界
set so=7

" 警示線
set colorcolumn=81,121

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" 顯示游標位置
set ruler
" 預設顯示相對行號
set number
set relativenumber
" 顯示指令
set showcmd
" 將指令列調整為 2 行, 比較好顯示訊息, [coc.nvim RC]
set cmdheight=2
" A buffer becomes hidden when it is abandoned, [coc.nvim RC]
set hidden
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" 搜尋時不分大小寫
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" 跑巨集時延緩重繪, 較有效率
set lazyredraw
" For regular expressions turn magic on
set magic
" 顯示對應括號
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" 等待毫秒沒有輸入後觸發 plugins, 預設等 4000ms [coc.nvim RC]
set updatetime=300
" [coc.nvim RC]
set shortmess+=c
set signcolumn=yes

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
" set foldcolumn=1
set ambiwidth=double

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

set t_Co=256

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" 標記多餘空白
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

colorscheme wombat256mod

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 關閉備份檔案, 有 Git 就好; 部分 Server 處理這些檔案會有問題 [coc.nvim RC]
set nobackup
set nowritebackup
set noswapfile

" Better handle JSONC (JSON with Comment //)
autocmd FileType json syntax match Comment +\/\/.\+$+

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai   " Auto indent
set si   " Smart indent
set wrap " Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode 按下 # / * 找所有相同的文字
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Close the current buffer
map <Leader>bd :Bclose<CR>:tabclose<CR>gT

" Close all the buffers
map <Leader>ba :bufdo bd<CR>

map <Leader>l :bnext<CR>
map <Leader>h :bprevious<CR>

" Useful mappings for managing tabs
map <Leader>tn :tabnew<CR>
map <Leader>to :tabonly<CR>
map <Leader>tq :tabclose<CR>
map <Leader>tm :tabmove
map <Leader>tt :tabnext<CR>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
autocmd TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <Leader>te :tabedit <c-r>=expand("%:p:h")<CR>/

" Switch CWD to the directory of the open buffer
map <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line 如果沒有 vim-airline 則啟用這個
if (!exists("loaded_airline"))
  set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
" -------------------
" noremap: 不會遞迴的 mapping (noremap Y y + noremap y Y 不會發生無窮迴圈)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 上下移動行 (區塊)
" M - 必須將 iTerm2 option key 設定為 ESC+ (Meta)
nmap <M-j> mz:m+<CR>`z
nmap <M-k> mz:m-2<CR>`z
vmap <M-j> :m'>+<CR>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<CR>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" 取消 highlight <Leader><CR>
map <silent> <Leader><CR> :noh<CR>

" 維持使用 ctrl + d 刪除後方字元
inoremap <C-d> <DELETE>

" Plugin binding
nmap <silent><C-n> :NERDTreeToggle<CR>

" 禁用方向鍵移動
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" ,q 快速開啟空白 buffer
map <Leader>q :e ~/buffer<CR>
" ,x 快速開啟 Markdown buffer
map <Leader>x :e ~/buffer.md<CR>

" 快速存檔
nmap <Leader>w :w!<CR>

" 切換行號顯示方式
nmap <Leader>n :set rnu!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins (via vim-plug)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :PlugInstall
call plug#begin('~/.vim/plugged') " 避免使用預設的 ~/.vim/plugin

    " 好看
    Plug 'bling/vim-airline'               " statusline
    Plug 'vim-airline/vim-airline-themes'  " statusline

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " 檔案瀏覽
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'xuyuanp/nerdtree-git-plugin'     " 在 NERDTree 中顯示 Git status
    Plug 'kien/ctrlp.vim'                  " ctrl + p
    Plug 'tpope/vim-projectionist'         " 前往相對應檔案, :A
    Plug 'majutsushi/tagbar'               " Show tags/outline (F8)
    Plug 'ludovicchabant/vim-gutentags'    " 自動生成 tags

    " 編輯工具
    Plug 'editorconfig/editorconfig-vim'
    Plug 'anyakichi/vim-surround'          " 增加 s selector, cs'<p> 將單引號改為 <p>
    Plug 'ntpeters/vim-better-whitespace' " 顯示 trailing whitespace, 包含刪除 function StripWhitespace

    " 各種語言
    Plug 'leafgarland/typescript-vim'
    Plug 'rayburgemeestre/phpfolding.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisence engine for vim8 & neovim
                                                    " 需要自行安裝 language server plugin
                                                    " e.g. :CocInstall coc-phpls
call plug#end()

nnoremap <silent> <Leader>o :TagbarToggle<CR>

" 存擋時自動刪除行尾空白
autocmd BufWritePre *.txt,*.js,*.py,*.md,*.sh,*.php,*.ts,*.scss,*.vim :StripWhitespace

" airline 相關調整, 字體可參考: https://github.com/powerline/fonts
let g:airline_theme='bubblegum' " 預覽 https://github.com/vim-airline/vim-airline/wiki/screenshots
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let g:DisableAutoPHPFolding = 1 " 自行使用 :EnableFastPHPFolds 收合 PHP file

" 設定 CTags 路徑, 原設定在 <root>/ctags 很干擾
set tags=./.tags;,.tags
let g:gutentags_ctags_tagfile='.ctags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
set statusline+=%{gutentags#statusline()}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Auto toggle paste mode while pasting
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc.nvim 配置
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 前方有文字時, 用 <TAB> / <Shift><TAB> 瀏覽切換自動完成選項
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <Shift><ENTER> 觸發自動完成
inoremap <silent><expr> <S-CR> coc#refresh()

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
" nmap <Leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <Leader>f  <Plug>(coc-format-selected)
" nmap <Leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<Leader>aap` for current paragraph
xmap <Leader>a  <Plug>(coc-codeaction-selected)
nmap <Leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <Leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <Leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" 格式化當前 Buffer
command! -nargs=0 Format :call CocAction('format')

" 收合當前 Buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" 整理 imports
command! -nargs=0 OrganizeImport  :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<CR>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<CR>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<CR>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<CR>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<CR>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

