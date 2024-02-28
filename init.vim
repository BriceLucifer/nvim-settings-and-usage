" 初始化插件管理器 vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" 界面美化插件
Plug 'vim-airline/vim-airline' " 状态栏美化
Plug 'vim-airline/vim-airline-themes' " 状态栏主题
Plug 'kyazdani42/nvim-web-devicons' " 文件图标

" 颜色方案
Plug 'joshdick/onedark.vim' " One Dark 主题
Plug 'Mofiqul/dracula.nvim'  " Dracula Pro 主题 (专为 Neovim 设计)
Plug 'rakr/vim-one' " Vim One 主题
Plug 'morhetz/gruvbox' " Gruvbox 主题
Plug 'ful1e5/onedark.nvim' " OneDark Pro 主题
Plug 'ChristianChiarulli/nvcode-color-schemes.vim' " NVCode 主题，提供纯黑背景

" 编辑增强插件
Plug 'godlygeek/tabular' " 对齐文本
Plug 'plasticboy/vim-markdown' " Markdown 编辑
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'ferrine/md-img-paste.vim' " Markdown 图片粘贴
Plug 'preservim/nerdtree' " 文件浏览器

" 代码开发插件
Plug 'neoclide/coc.nvim', {'branch': 'release'} " 代码补全
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " 语法高亮
Plug 'nvim-lua/plenary.nvim' " Lua 函数库，某些插件依赖
Plug 'nvim-telescope/telescope.nvim' " 强大的搜索工具
Plug 'neovim/nvim-lspconfig' " 语言服务器配置
Plug 'tpope/vim-fugitive' " Git 集成
Plug 'SirVer/ultisnips' " 代码片段
Plug 'honza/vim-snippets' " 代码片段库
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Go 语言开发支持

" 结束插件列表
call plug#end()

" 配置选项
set background=dark " 设置背景为暗色
colorscheme dracula
set termguicolors
let g:vim_markdown_folding_disabled = 1
set number " 显示行号


" 快捷键映射
map <F2> :NERDTreeToggle<CR>
nmap <silent> <F8> <Plug>MarkdownPreview
imap <silent> <F8> <Plug>MarkdownPreview
nmap <silent> <F9> <Plug>StopMarkdownPreview
imap <silent> <F9> <Plug>StopMarkdownPreview
autocmd FileType markdown nmap <buffer><silent> <leader>i :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = '.'
let g:mdip_imgname = 'image'

" 补全和代码片段配置
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" 激活 vim-go 自动补全
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_fmt_command = 'goimports'

" 设置 Go 语言的编译器和错误信息格式化程序
let g:go_metalinter_command = 'golangci-lint'
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

" CoC 插件扩展安装提示
" 请在 Neovim 中运行以下命令安装对应语言的 CoC 扩展：
" :CocInstall coc-python coc-rust-analyzer coc-clangd coc-tsserver
" 这将分别安装 Python、Rust、C/C++ 和 TypeScript 的支持。

" Treesitter 语言安装提示
" 使用 :TSInstall
