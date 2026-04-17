return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = function()
    local app_dir = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app"
    vim.fn.jobstart({ "npm", "install" }, { cwd = app_dir })
  end,
}
