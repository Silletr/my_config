-- 🔧  base setting
vim.g.python3_host_prog = '/usr/bin/python3.10'
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.clipboard = 'unnamedplus'
vim.g.mapleader = '<H>'

-- 🧩 Packer setup
local packer_ok, packer = pcall(require, 'packer')
if not packer_ok then
  vim.notify("Packer not found!", vim.log.levels.ERROR)
  return
end

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
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
    }
  -- nvim notify
  use({
    "rcarriga/nvim-notify",
    config = function()
        vim.notify = require("notify") 
    end,
    })


  -- my plugin
  use {
    'Silletr/LazyDeveloperHelper',
    config = function()
      require("LazyDeveloperHelper").setup()
    end
  }

  -- LSP
  use {
     'williamboman/mason.nvim',
  }
  use 'williamboman/mason-lspconfig.nvim'
  use 'https://github.com/neovim/nvim-lspconfig'

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',      
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets', 
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup{
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>']     = cmp.mapping.confirm({ select = true }),
          ['<Tab>']    = cmp.mapping(function(fallback)
                            if cmp.visible() then cmp.select_next_item()
                            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
                            else fallback() end
                          end, { 'i','s' }),
          ['<S-Tab>']  = cmp.mapping(function(fallback)
                            if cmp.visible() then cmp.select_prev_item()
                            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
                            else fallback() end
                          end, { 'i','s' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      }
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } }
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
      })
    end
  }
 -- 🎨 Theme
  use {
    'folke/tokyonight.nvim',
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = true,
        terminal_colors = true,
      })
      vim.cmd[[colorscheme tokyonight]]
    end
  }

  -- 🌐 Icons
  use { 'nvim-tree/nvim-web-devicons' }

  -- 🌲 File Tree
  use {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        renderer = {
          add_trailing = false,
          group_empty = true,
          highlight_git = true,
          root_folder_modifier = ':t',
          indent_markers = {
            enable = true,
            icons = {
              corner = '└',
              edge = '│',
              item = '│',
              none = ' ',
            },
          },
          icons = {
            glyphs = {
              default = '',
              symlink = '',
              folder = {
                default = '',
                open = '',
                empty = '',
                empty_open = '',
                symlink = '',
              },
              git = {
                unstaged = '✗',
                staged = '✓',
                unmerged = '',
                renamed = '➜',
                deleted = '',
                ignored = '◌',
              },
            },
          },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            error = 'E',
            warning = 'W',
            hint = 'H',
            info = 'I',
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
          ignore_list = {},
        },
        filters = {
          dotfiles = true,
          custom = {},
          exclude = {'.git', 'node_modules', '.cache'},
        },
        git = {
          enable = true,
          ignore = true,
          timeout = 400,
        },
        trash = {
          cmd = 'trash',
          require_confirm = true,
        },
        actions = {
          open_file = {
            quit_on_open = true,
            resize_window = true,
          },
        },
      })
    end
  }

end)

require('mason').setup()
require('mason-lspconfig').setup {
    ensure_installed = { 'pyright', 'lua_ls' },
    automatic_installation = false, 
  }
local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) 
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting or vim.lsp.buf.format, opts)
end

lspconfig.pyright.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      }
    }
  }
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = { globals = {'vim', 'use'} },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    }
  }
}

vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap=true, silent=true })
vim.keymap.set("n", "<C-g>", ":NvimTreeFindFile<CR>", { noremap=true, silent=true })
