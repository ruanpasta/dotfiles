" ==========================================================================
" # Editor settings
" =========================================================================

syntax on "enable highlighting
set number "enable line number
set relativenumber " line numbers relative to current line
set encoding=utf-8 " Visualizar na codificacao desejada
set fileencoding=utf-8 " Salvar na codificacao desejada
filetype plugin indent on " allow auto filtype plugin and indentation configuration
set hidden
set nobackup
set nowritebackup
set cursorline " Enable highlight current cursor line

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

"identation
set autoindent
set smartindent
set tabstop=2 " Tamanho do tab
set shiftwidth=2
set expandtab
set softtabstop=2 " Backspace respeitar identacao
set scrolloff=2
set nowrap
set showtabline=2 "allways show tab name
set nojoinspaces
" set incsearch  Busca incremental - feedback enquanto busca no vim"
" set hlsearch  Destaque nos resultados

"print options
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter

" coc config
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json', 
  \ 'coc-vetur',
  \ 'coc-diagnostic',
  \ 'coc-prettier',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-pyright',
  \ 'coc-tabnine',
  \ 'coc-svelte',
  \ ]


" ==========================================================================
" # Util Functions 
" ==========================================================================

" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

"get current file specific formatter
function! Get_default_formatter_command()
  let current_filetype = &filetype 
  let formatters = { 
   \'cs': ':OmniSharpCodeFormat',
   \'rs': ':RustFmt',
   \'rust': ':RustFmt',
   \'javascript': ':PrettierAsync',
   \'typescript': ':PrettierAsync',
   \'typescriptreact': ':PrettierAsync',
   \'javascriptreact': ':PrettierAsync',
   \'js': ':PrettierAsync',
   \'ts': ':PrettierAsync',
   \'json': ':PrettierAsync',
   \'vue': ':PrettierAsync',
   \'jsx': ':PrettierAsync',
   \'tsx': ':PrettierAsync',
   \'html': ':PrettierAsync',
   \'css': ':PrettierAsync',
   \'scss': ':PrettierAsync',
   \'svelte': ':PrettierAsync',
   \}
  if has_key(formatters, current_filetype)
    execute formatters[current_filetype]
  else
    echo "No installed formatter for this type of file"
  endif
  
endfunction

function! NERDTreeToggleInCurDir()
  let current_dir = expand('%:p')
  execute ":NERDTreeToggle ".current_dir
endfunction

" =============================================================================
" # Remappings 
" =============================================================================
" 
" Map leader to space
let mapleader = "\<Space>"

" map coc prettier format to <C-F>
nmap <C-F> :call Get_default_formatter_command() <CR>

" toggle nerdtree filesystem in current folder with <C-B>
nmap <C-B> :call NERDTreeToggleInCurDir()<CR>

" fzf commands remaps
silent! nmap <C-P> :Files<CR>
" silent! nmap <C-P> :GFiles<CR>
" map <leader>f :Files <CR>
map <F1> :Ag<CR> 
map <leader>f :Buffers<CR>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Go To definition remappings
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)

"show all open tabs
nnoremap <leader>tl :tabs<cr>

"switch to previous tab
nnoremap <leader>tq :tabprevious<cr>

"switch to next tab
nnoremap <leader>tp :tabnext<cr>

"create new empty tab
nnoremap <leader>tn :tabnew<cr>

"close current tab
nnoremap <leader>tc :tabclose<cr>

" update tab name
nnoremap <leader>trn :TabooRename

" Remap keys for applying codeAction to the current line.
nmap <leader>do  <Plug>(coc-codeaction)                                                                                                                           

" Apply AutoFix to problem on the current line.
nmap <leader>df  <Plug>(coc-fix-current)

" Map jj keys to leave insert mode
inoremap jj <Esc>
tnoremap jj <C-\><C-n>

" Open MarkdownPreview
nnoremap <leader>md :MarkdownPreview<cr>

" Commentary comand
noremap <leader>/ :Commentary<cr>

" ==========================================================================
" # Plugins 
" ==========================================================================

call plug#begin()

" Navigation Plugins"
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Fast Finder for files, buffer ...
Plug 'airblade/vim-rooter' "Set the work directory to the root of the current project

" Languages pack
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'OmniSharp/omnisharp-vim'
Plug 'leafgarland/typescript-vim' " Typescript highlighter

" Eslint for JS"                                                                                                                                                   
Plug 'dense-analysis/ale'

" Autocomplete stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Code smells
Plug 'machakann/vim-highlightedyank' "highlight copied content
Plug 'editorconfig/editorconfig-vim'

" git related stuff
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'

" Bottom line 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Formating
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'tsx', 'typescriptreact', 'javascriptreact', 'svelte'] }

" Color themes
Plug 'dikiaap/minimalist'
Plug 'altercation/solarized'
Plug 'morhetz/gruvbox'
Plug 'ajh17/spacegray.vim'
Plug 'sainnhe/sonokai'
Plug 'savq/melange'
Plug 'ayu-theme/ayu-vim'
Plug 'erichdongubler/vim-sublime-monokai'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ajmwagar/vim-deus'
Plug 'kyazdani42/blue-moon'

" Code previews
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" FrontEnd helpers
Plug 'ap/vim-css-color'
Plug 'gregsexton/matchtag'

" Editor helpers
Plug 'tpope/vim-commentary'

" Line highlighting
Plug 'danilamihailov/beacon.nvim' "Hightlight current line after a jump
Plug 'inside/vim-search-pulse' "Hightlight current line after a search

" Performance plugins
Plug 'dstein64/vim-startuptime'

call plug#end()

" =============================================================================
" # Visual settings
" =============================================================================

" colorscheme stuff
set termguicolors
set t_Co=256
set background=dark
colorscheme dracula
" colorscheme blue-moon

" vim-airline configurations
let g:airline_theme='base16_spacemacs'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagline#enabled = 1

" =============================================================================
" # Settings
" =============================================================================

" Run lint after insert leave
let g:ale_lint_on_insert_leave=1 

" Ignore node_modules on FzF search with :Files
let $FZF_DEFAULT_COMMAND='find . \( -name node_modules -o -name dist -o -name .nuxt -o -name .git \) -prune -o -print'


" Comandos uteis 
" C-a + elemento ( C-a{ ) Deleta tudo daqueleas chaves
" Y-i-w
" v-i-w
" C-a + , ( C-a, ) renoimeia a tab do Tmux 
"
