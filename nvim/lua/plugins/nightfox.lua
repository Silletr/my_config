return {
  "EdenEast/nightfox.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("nightfox").setup({
      options = {

        --    ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
        --    ┃       Glowing styles       ┃
        --    ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
        styles = {
          comments = "italic",
          conditionals = "bold,italic",
          constants = "bold",
          functions = "italic,bold",
          keywords = "bold",
          numbers = "NONE",
          operators = "bold",
          strings = "italic",
          types = "bold,italic",
          variables = "NONE",
        },
        inverse = {
          match_paren = false,
          visual = false,
          search = false,
        },
        modules = {},
      },
      palettes = {},
      specs = {},
      groups = {},
    })

    -- Load the colorscheme (duskfox is one variant; options: nightfox, duskfox, dawnfox, dayfox, carbonfox, terafox, nordfox)
    vim.cmd("colorscheme duskfox")
  end,
}
