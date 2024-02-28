" 初始化插件管理器 vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Markdown 编辑支持
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown', 'cmd': 'MarkdownPreview' }
Plug 'ferrine/md-img-paste.vim', {'for': 'markdown'}

" 文件浏览器
Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'}

" 代码补全
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}

" 语法高亮
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Lua 函数库，某些插件依赖
Plug 'nvim-lua/plenary.nvim'

" 强大的搜索工具
Plug 'nvim-telescope/telescope.nvim', {'cmd': 'Telescope'}

" 语言服务器配置
Plug 'neovim/nvim-lspconfig'

" Git 集成
Plug 'tpope/vim-fugitive'

" 代码片段
Plug 'SirVer/ultisnips', {'on': ['UltiSnipsEdit', 'UltiSnipsListSnippets']}
Plug 'honza/vim-snippets'

" 结束插件列表
call plug#end()

" 配置选项
colorscheme gruvbox " 激活 gruvbox 主题
set number " 显示行号
syntax on " 开启语法高亮

" 快捷键映射
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F8> :MarkdownPreview<CR>
nnoremap <F9> :MarkdownPreviewStop<CR>
autocmd FileType markdown nnoremap <buffer><silent> <leader>i :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = 'img'
let g:mdip_imgname = 'clipboard_img_%Y%m%d%H%M%S'

" 补全和代码片段配置
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" CoC 配置
let g:coc_global_extensions = ['coc-snippets', 'coc-pairs', 'coc-tsserver', 'coc-python', 'coc-rust-analyzer', 'coc-clangd']

" Treesitter 配置
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

" Telescope 配置
nnoremap <leader>f :Telescope find_files<CR>
nnoremap <leader>g :Telescope live_grep<CR>

" Vim 编辑器行为优化
set noswapfile " 关闭交换文件
set nobackup " 关闭备份文件
set nowritebackup " 关闭写入备份文件
set updatetime=300 " 加快更新时间
set shortmess+=c " 不显示补全时的消息

" 如果有更多具体的功能需求，可以继续添加相应的配置项
