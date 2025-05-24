return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
  { "shaunsingh/nord.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
