-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")
