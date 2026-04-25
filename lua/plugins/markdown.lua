-- 极简Markdown配置
-- 只保留编辑器内渲染，无语法检查

return {
  -- 浏览器Markdown预览
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_browser = ""

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", {
            desc = "Markdown Preview Toggle",
            buffer = true,
          })
        end,
      })
    end,
  },

  -- Markdown渲染
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      checkbox = {
        enabled = false,
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      -- 配置键绑定
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("n", "<leader>um", function()
            require("render-markdown").toggle()
          end, { desc = "Toggle Render Markdown", buffer = true })
        end,
      })
    end,
  },
}
