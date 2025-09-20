-- 禁用 Markdown 语法检查和诊断
return {
  -- 禁用 conform.nvim 对 markdown 的格式化
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      -- 清空 markdown 格式化器
      opts.formatters_by_ft["markdown"] = {}
      opts.formatters_by_ft["markdown.mdx"] = {}
      return opts
    end,
  },

  -- 禁用 nvim-lint 对 markdown 的检查
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      -- 清空 markdown linters
      opts.linters_by_ft["markdown"] = {}
      return opts
    end,
  },

  -- 禁用 none-ls 对 markdown 的诊断
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      -- 过滤掉 markdown 相关的诊断
      opts.sources = vim.tbl_filter(function(source)
        if source.name and string.match(source.name, "markdown") then
          return false
        end
        return true
      end, opts.sources)
      return opts
    end,
  },

  -- 禁用 LSP 对 markdown 的诊断
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- 禁用 marksman LSP
        marksman = false,
      },
    },
  },
}
