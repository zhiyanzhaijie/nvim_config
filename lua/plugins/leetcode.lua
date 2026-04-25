return {
  {
    "kawre/leetcode.nvim",
    enabled = true,
    cmd = "Leet",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lang = "rust",
      editor = {
        reset_previous_code = false,
      },
      translator = true,
      cn = {
        enabled = false,
        translator = true,
        translate_problems = true,
      },
      image_support = false,
      hooks = {
        ["question_enter"] = {
          function(question)
            if question.lang ~= "rust" then
              return
            end
            local storage_home = vim.fn.stdpath("data") .. "/leetcode"
            local rs_files = vim.fn.globpath(storage_home, "*.rs", false, true)
            if #rs_files == 0 then
              return
            end
            table.sort(rs_files)

            local crates = {}
            for _, file in ipairs(rs_files) do
              crates[#crates + 1] = {
                root_module = file,
                edition = "2021",
                deps = {},
              }
            end

            local sysroot = vim.trim(vim.fn.system("rustc --print sysroot"))
            if vim.v.shell_error ~= 0 or sysroot == "" then
              return
            end

            local project_file = io.open(storage_home .. "/rust-project.json", "w")
            if not project_file then
              return
            end
            local ok_encode, payload = pcall(vim.json.encode, {
              sysroot_src = sysroot .. "/lib/rustlib/src/rust/library",
              crates = crates,
            })
            if ok_encode and payload then
              project_file:write(payload)
            end
            project_file:close()
            if not ok_encode then
              return
            end

            local ok_lsp, lsp = pcall(require, "rustaceanvim.lsp")
            if not ok_lsp then
              return
            end
            local bufnr = question.bufnr or vim.api.nvim_get_current_buf()
            lsp.stop(bufnr)
            vim.defer_fn(function()
              if vim.api.nvim_buf_is_valid(bufnr) then
                lsp.start(bufnr)
              end
            end, 120)
          end,
        },
      },
    },
    keys = {
      { "<leader>Ll", "<cmd>Leet list<cr>", desc = "LeetCode list" },
      { "<leader>Lt", "<cmd>Leet test<cr>", desc = "LeetCode test" },
      { "<leader>Ls", "<cmd>Leet submit<cr>", desc = "LeetCode submit" },
      { "<leader>Lr", "<cmd>Leet last_submit<cr>", desc = "LeetCode Last Submit" },
    },
  },
}
