-- 🔧 Base settings
vim.g.python3_host_prog = '/usr/bin/python3.10'
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.opt.clipboard:append("unnamedplus")
vim.g.mapleader = '<H>'

-- 🧩 Lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'folke/lazy.nvim' },

  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- ASCII header
      dashboard.section.header.val = {
        [[  ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗]],
        [[  ██║     ██╔══██╗██╔════╝██║   ██║██║   ██║██║████╗ ████║]],
        [[  ██║     ███████║███████╗██║   ██║██║   ██║██║██╔████╔██║]],
        [[  ██║     ██╔══██║╚════██║██║   ██║██║   ██║██║██║╚██╔╝██║]],
        [[  ███████╗██║  ██║███████║╚██████╔╝╚██████╔╝██║██║ ╚═╝ ██║]],
        [[  ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝     ╚═╝]],
        [[                          LazyVim zzz...                  ]],
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "🔍  Find file", ":Telescope find_files<CR>"),
        dashboard.button("n", "📄  New file", ":ene <BAR> startinsert<CR>"),
        dashboard.button("r", "🕑  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "🔎  Find text", ":Telescope live_grep<CR>"),
        dashboard.button("c", "⚙️ Config", ":e ~/.config/nvim/init.lua<CR>"),
        dashboard.button("s", "💾 Restore Session", ":SessionRestore<CR>"),
        dashboard.button("l", "⚡ Lazy", ":Lazy<CR>"),
        dashboard.button("q", "❌  Quit", ":qa<CR>"),
      }

      alpha.setup(dashboard.config)
    end
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'tokyonight',
          icons_enabled = true,
          section_separators = '',
          component_separators = '',
        }
      }
    end
  },

  -- Notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end
  },

  -- Custom plugin
  {
    'Silletr/LazyDeveloperHelper',
    config = function()
      require("LazyDeveloperHelper").setup()
    end
  },

  -- LSP
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      }
    end
  },

  -- Theme
  {
    'folke/tokyonight.nvim',
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = true,
        terminal_colors = true,
      })
      vim.cmd[[colorscheme tokyonight]]
    end
  },

  -- Icons
  { 'nvim-tree/nvim-web-devicons' },

  -- File Tree
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()
    end
  },
}, {
  performance = {
    rtp = {
      reset = true,
    },
  },
})

-- LSP Setup
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = { 'pyright', 'lua_ls' },
  automatic_installation = false,
}

local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
end

lspconfig.pyright.setup { on_attach = on_attach }
lspconfig.lua_ls.setup { on_attach = on_attach }

-- Keymaps for NvimTree
vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-g>", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })


