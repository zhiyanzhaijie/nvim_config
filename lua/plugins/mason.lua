return {
  "mason-org/mason.nvim",
  keys = {
    -- { "<leader>cm", false },
  },
  opts = {
    ensure_installed = {
      "html-lsp",
      "typescript-language-server",
      "tailwindcss-language-server",
    },
  },
}
