-- 自动安装 Packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

require('packer').startup(function()
  -- Packer 可以管理自己
  use 'wbthomason/packer.nvim'
  -- 插件列表
  use 'gruvbox-community/gruvbox' -- 主题颜色方案
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "scottmckendry/cyberdream.nvim", as = "cyberdream" }
  use {"folke/tokyonight.nvim", as = "tokyonight"}

  use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',     -- telescope插件
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'hoob3rt/lualine.nvim', -- 状态栏
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  --nvim-tree
  use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons',}, --optional
  }
  use 'neovim/nvim-lspconfig' -- LSP 支持
  use 'simrat39/rust-tools.nvim' -- rust-tools
  use 'hrsh7th/nvim-cmp' -- 自动补全引擎
  use 'hrsh7th/cmp-nvim-lsp' -- LSP 自动补全源
  use 'hrsh7th/cmp-buffer' -- 缓冲区补全源
  use 'hrsh7th/cmp-path' -- 路径补全源
  use 'hrsh7th/cmp-cmdline' -- 命令行补全源
  use 'L3MON4D3/LuaSnip' -- 代码片段引擎
  use 'saadparwaiz1/cmp_luasnip' -- LuaSnip 补全源
  use 'windwp/nvim-autopairs' -- 括号自动补全
  use 'nvim-treesitter/nvim-treesitter' -- 高级语法高亮
  use({"stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
    }) -- oil插件
  use {'gen740/SmoothCursor.nvim'} --SmoothCursor插件

end)

-- LSP 基础设置
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

-- LSP 服务器设置
require'lspconfig'.clangd.setup{ on_attach = on_attach }
require'lspconfig'.rust_analyzer.setup{ on_attach = on_attach }
require'lspconfig'.pyright.setup{ on_attach = on_attach }
require'lspconfig'.bashls.setup{ on_attach = on_attach }

-- nvim-cmp 自动补全设置
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  })
})

-- 主题设置
vim.o.termguicolors = true
vim.cmd[[colorscheme cyberdream]]

-- nvim-tree
require("nvim-tree").setup{}
vim.keymap.set('n','<A-m>',":NvimTreeToggle<CR>")

-- buffertab设置
require("bufferline").setup {
    options = {
        -- 使用 nvim 内置lsp
        diagnostics = "nvim_lsp",
        -- 左侧让出 nvim-tree 的位置
        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
        }}
    }
}
vim.keymap.set('n',"<C-h>",":BufferLineCyclePrev<CR>")
vim.keymap.set('n',"<C-l>",":BufferLineCycleNext<CR>")

-- 状态栏设置
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
  },
}

-- 显示行号设置
vim.o.number = true               -- 开启绝对行号
vim.o.relativenumber = true       -- 开启相对行号

-- nvim-autopairs 设置
require('nvim-autopairs').setup{}

-- Treesitter 设置
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- 或者一个你想要支持的语言列表
  highlight = {
    enable = true,
  },
}

-- rust-tools
require('rust-tools').setup{}

-- telescope快捷键
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- terminal mode 快捷键
vim.keymap.set('t', '<A-e>', "<C-\\><C-n>")

-- oil 插件
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- SmoothCursor 插件
require('smoothcursor').setup({
        type = "matrix",
})

-- 运行 PackerCompile，如果 init.lua 被更改
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])
