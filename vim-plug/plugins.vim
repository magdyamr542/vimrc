" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')
        Plug 'Mofiqul/vscode.nvim'
        Plug 'jiangmiao/auto-pairs'
        Plug 'kyazdani42/nvim-web-devicons'
        Plug 'tomasiser/vim-code-dark'
        Plug 'ayu-theme/ayu-vim' 
        Plug 'ambv/black'
        Plug 'NLKNguyen/papercolor-theme'
        Plug 'nvim-lua/popup.nvim'
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'
        Plug 'sheerun/vim-polyglot'
        Plug 'scrooloose/NERDTree'
        Plug 'RRethy/vim-illuminate'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'sbdchd/neoformat'
        Plug 'pangloss/vim-javascript'    
        Plug 'leafgarland/typescript-vim' 
        Plug 'morhetz/gruvbox'
        Plug 'unblevable/quick-scope'       
        Plug 'liuchengxu/vim-which-key'
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-surround'
        Plug 'dense-analysis/ale'
        Plug 'voldikss/vim-floaterm'
        Plug 'flazz/vim-colorschemes'
        Plug 'preservim/nerdcommenter'
        Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
        Plug 'rafi/awesome-vim-colorschemes'
call plug#end()

"MAPPINGS FOR THE PLUGINS

" ts-server
let g:coc_global_extensions = [ 'coc-tsserver' ]

" quickscope color mappings
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" Floaterm
let g:floaterm_autoinsert=1
let g:floaterm_width=3
let g:floaterm_height=0.3
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1
let g:floaterm_position="bottom"
let g:floaterm_wintype="split"


"display buffers
let g:airline#extensions#tabline#enabled = 1