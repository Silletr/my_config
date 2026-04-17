return {
  "vyfor/cord.nvim",
  opts = {
    display = {
      theme = "classic",
      flavor = "dark",
      swap_fields = true,
    },
    timestamp = {
      shared = true,
    },
    buttons = {
      {
        label = "View Repository",
        url = function(opts)
          return opts.repo_url
        end,
      },
    },
  },
}
