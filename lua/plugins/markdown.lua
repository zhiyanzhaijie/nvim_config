-- 极简Markdown配置
-- 只保留编辑器内渲染，无语法检查

return {
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
