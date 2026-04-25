return {
  {
    "mrcjkb/rustaceanvim",
    lazy = false,
    opts = function(_, opts)
      opts.server = opts.server or {}
      local prev_on_attach = opts.server.on_attach
      opts.server.on_attach = function(client, bufnr)
        if prev_on_attach then
          prev_on_attach(client, bufnr)
        end
        -- 禁用 inlay hints
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
      end
      opts.server.default_settings = opts.server.default_settings or {}
      opts.server.default_settings["rust-analyzer"] = vim.tbl_deep_extend(
        "force",
        opts.server.default_settings["rust-analyzer"] or {},
        {
          files = {
            watcher = "server",
          },
        }
      )
    end,
  },
}
