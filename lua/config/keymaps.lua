-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua Add any additional keymaps here
-- Keymaps are automatically loaded on the VeryLazy event

-- 在 macOS 上，Alt+H 产生的是奇怪字符。使用以下方式处理：
-- 方法1：使用 <M-h> 而不是 Alt+H 来定义快捷键
-- 方法2：在终端配置中设置 Option 键的行为

-- 如果你使用的是 fzf-lua 的 grep/live_grep，可以尝试以下配置：
-- vim.keymap.set('n', '<M-h>', '<cmd>lua require("fzf-lua").grep{search_hidden=not vim.g.fzf_search_hidden}<cr>', { noremap = true })
-- vim.g.fzf_search_hidden = false
