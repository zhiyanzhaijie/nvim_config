-- Markdown 专用配置 - 简化版
-- 遵循SOLID原则，只保留核心功能

local M = {}

-- Markdown 自动命令配置
function M.setup_autocmds()
  local augroup = vim.api.nvim_create_augroup("MarkdownConfig", { clear = true })

  -- 进入 Markdown 文件时设置专用选项
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "markdown", "md" },
    callback = function()
      -- 设置 Markdown 专用选项
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
      vim.opt_local.conceallevel = 2
      vim.opt_local.concealcursor = "n"
      vim.opt_local.spell = false -- 关闭拼写检查

      -- 设置缩进
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
      vim.opt_local.softtabstop = 2
      vim.opt_local.expandtab = true

      -- 禁用自动折叠
      vim.opt_local.foldenable = false

      -- 禁用语法检查和诊断
      vim.diagnostic.enable(false, { bufnr = 0 })

      -- 关闭 LSP 诊断
      vim.b.diagnostics_enabled = false
    end,
  })
end

-- 初始化函数
function M.setup()
  M.setup_autocmds()
end

return M
