return {
  "Cartoone9/pretty-comment.nvim",
  --    ╭───────────────────────────────────────────────────────────────────────────────╮
  --    │                             Recommended keybinds                              │
  --    ╰───────────────────────────────────────────────────────────────────────────────╯
  keys = {
    { "gbl", "<cmd>CommentLine<CR>", mode = "n", desc = "Centered title line" },
    { "gbl", ":CommentLine<CR>", mode = "v", desc = "Centered title line" },
    { "gbL", "<cmd>CommentLineFat<CR>", mode = "n", desc = "Fat centered title line" },
    { "gbL", ":CommentLineFat<CR>", mode = "v", desc = "Fat centered title line" },
    { "gbs", "<cmd>CommentSep<CR>", mode = "n", desc = "Comment separator" },
    { "gbS", "<cmd>CommentSepFat<CR>", mode = "n", desc = "Fat comment separator" },
    { "gbd", "<cmd>CommentDiv<CR>", mode = "n", desc = "Comment divider" },
    { "gbD", "<cmd>CommentDivFat<CR>", mode = "n", desc = "Fat comment divider" },
    { "gbr", "<cmd>CommentRemove<CR>", mode = "n", desc = "Strip comment decoration" },
    { "gbr", ":CommentRemove<CR>", mode = "v", desc = "Strip comment decoration" },
    { "gbe", "<cmd>CommentEqualize<CR>", mode = "n", desc = "Equalize decoration" },
    { "gbe", ":CommentEqualize<CR>", mode = "v", desc = "Equalize decoration (selection)" },
    { "gbx", "<cmd>CommentReset<CR>", mode = "n", desc = "Reset comment width tracking" },
    { "gbC", "<cmd>CommentBoxFat<CR>", mode = "n", desc = "Create fat comment box (line)" },
    { "gbC", ":CommentBoxFat<CR>", mode = "v", desc = "Create fat comment box (selection)" },
  },
  --    ╭───────────────────────────────────────────────────────────────────────────────╮
  --    │    gc* keybinds above add a delay to visual 'gc' comment toggle. Use 'gcc'    │
  --    │                 in visual mode to toggle comments instantly.                  │
  --    ╰───────────────────────────────────────────────────────────────────────────────╯
  init = function()
    vim.keymap.set("x", "gcc", function()
      return require("vim._comment").operator()
    end, { expr = true, desc = "Comment toggle (instant, avoids gc delay)" })
  end,
  config = function(_, opts)
    require("pretty-comment").setup(opts)
  end,
  opts = {},
}
