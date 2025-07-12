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

  -- 🎨 Theme
  use {
    'folke/tokyonight.nvim',
    config = function()
      require("tokyonight").setup({
        style = "moon",
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
          dotfiles = false,
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

local lazy_ok, lazy = pcall(require, "LazyDeveloperHelper.plugin.commands")
if lazy_ok and lazy.commands then lazy.commands() end

vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap=true, silent=true })
vim.keymap.set("n", "<C-g>", ":NvimTreeFindFile<CR>", { noremap=true, silent=true })

vim.cmd[[colorscheme tokyonight]]
