" Vim Plug

if has('nvim')
  call plug#begin('~/.config/nvim/plugged')
else
  call plug#begin('~/.vim')
endif

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color Schemes
Plug 'flazz/vim-colorschemes'

" NERDTree
Plug 'preservim/nerdtree'

" NERD Commenter
Plug 'scrooloose/nerdcommenter'" vim-ripgrep
Plug 'jremmen/vim-ripgrep'" Surround
Plug 'tpope/vim-surround'

" Syntastic
Plug 'vim-syntastic/syntastic'

" Ale
"Plug 'dense-analysis/ale'

" vim-elixir-ls
Plug 'elixir-lsp/elixir-ls', { 'do': { -> g:ElixirLS.compile() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vim-elixir
Plug 'elixir-editors/vim-elixir'

" Snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

" vim-test
Plug 'janko/vim-test'

" Onedark theme
Plug 'joshdick/onedark.vim'

" Fzf for searching for files
" https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Initialize plugin system

call plug#end()

" Python
let g:python_host_prog="/usr/bin/python"
let g:python3_host_prog="/usr/local/bin/python3"
set pyxversion=3

"
" COC
"

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
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
  else
    call CocAction('doHover')
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

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"
" End Coc
"
 
if has('nvim')
  "
  " ElixirLS
  "
  " Dependency for ElixirLS
  let g:coc_global_extensions = ['coc-elixir', 'coc-diagnostic']
  
  " ElixirLS config
  let g:ElixirLS = {}
  let ElixirLS.path = stdpath('config').'/plugged/elixir-ls'
  let ElixirLS.lsp = ElixirLS.path.'/release/language_server.sh'
  let ElixirLS.cmd = join([
  	\ 'asdf install &&',
  	\ 'mix do',
  	\ 'local.hex --force --if-missing,',
  	\ 'local.rebar --force,',
  	\ 'deps.get,',
  	\ 'compile,',
  	\ 'elixir_ls.release'
  	\ ], ' ')
  
  function ElixirLS.on_stdout(_job_id, data, _event)
    let self.output[-1] .= a:data[0]
    call extend(self.output, a:data[1:])
  endfunction
  
  let ElixirLS.on_stderr = function(ElixirLS.on_stdout)
  
  function ElixirLS.on_exit(_job_id, exitcode, _event)
    if a:exitcode[0] == 0
      echom '>>> ElixirLS compiled'
    else
      echoerr join(self.output, ' ')
      echoerr '>>> ElixirLS compilation failed'
    endif
  endfunction
  
  function ElixirLS.compile()
    let me = copy(g:ElixirLS)
    let me.output = ['']
    echom '>>> compiling ElixirLS'
    let me.id = jobstart(me.cmd, me)
  endfunction
  
  " If you want to wait on the compilation only when running :PlugUpdate
  " then have the post-update hook use this function instead:
  
  " function ElixirLS.compile_sync()
  "   echom '>>> compiling ElixirLS'
  "   silent call system(g:ElixirLS.cmd)
  "   echom '>>> ElixirLS compiled'
  " endfunction
  
  " Then, update the Elixir language server
  call coc#config('elixir', {
    \ 'command': g:ElixirLS.lsp,
    \ 'filetypes': ['elixir', 'eelixir']
    \})
  call coc#config('elixir.pathToElixirLS', g:ElixirLS.lsp)
  
endif
"
" End ElixirLS
"

"
" General settings
"

set shell=zsh

" Allow backspacing over everything
set backspace=indent,eol,start

" Enable incremental search
set incsearch

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3

"
" Enable mouse by default
set mouse=a

" '%%' becomes the directory of the current file
" For example, the command 'e %%' opens the directory of the current file
cabbr <expr> %% expand('%:p:h')


"
" Display
"

if has('nvim')
  colorscheme onedark
endif

set number
set cursorline

"
" vim-test
"

"function! ZshTransform(cmd) abort
  "return '. $HOME/.zshrc; '.a:cmd
"endfunction

"let g:test#custom_transformations = {'zsh': function('ZshTransform')}
"let g:test#transformation = 'zsh'

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
"let test#strategy = "vimterminal"
let test#strategy = "neovim"
let g:test#preserve_screen = 1

"
" Snippets
"

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsNoPythonWarning = 1
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"
" End Snippets
"

"
" Misc key bindings
"

" Copy the path of the curren buffer
nmap cp :let @" = expand("%")<cr>

" In terminal let Esc behave like it does everywhere else
:tnoremap <Esc> <C-\><C-n>

" Don't highlight results of a search
set nohlsearch

" switch to upper/lower window quickly
map <C-J> <C-W>j
map <C-K> <C-W>k

" Close buffer, but not window
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" List buffers
nmap <silent> <Leader>b :Buffers<CR>

nmap <silent> <C-P> :FZF<CR>
"
" map <F7> to toggle NERDTree window
nmap <silent> ,n :NERDTreeToggle<CR>

