return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        on_attach = function(client, bufnr)
          -- 禁用 inlay hints
          vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
        end,
      },
    },
  },
}
