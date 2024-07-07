vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>")

vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "moves to the leftside split" })
vim.keymap.set("n", "<M-l>", "<C-w>l", { desc = "moves to the rightside split" })

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "clears search highlights", silent = true })

