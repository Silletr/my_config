return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylyzer = { enabled = false },
        basedpyright = { enabled = false },
        pyright = {
          settings = {
            python = {
              pythonPath = "/usr/bin/python3",
            },
          },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "pyright" },
    },
  },
}
