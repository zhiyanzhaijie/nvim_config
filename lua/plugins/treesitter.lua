return {
  -- TreeSitter 语法高亮和解析器
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "css",
        "scss",
        "vue",
        "svelte",
        "astro",
      },
      -- 自动安装语言解析器
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
  },
  
  -- TreeSitter 文本对象
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    enabled = true,
    config = function()
      -- 新版本 nvim-treesitter-textobjects 使用不同的模块路径
      local ok_move, move = pcall(require, "nvim-treesitter-textobjects.move")
      if not ok_move then
        vim.notify("nvim-treesitter-textobjects.move not found", vim.log.levels.WARN)
        return
      end
      
      -- 在 diff 模式下，使用 vim 原生的跳转
      local goto_next_start = move.goto_next_start
      local goto_next_end = move.goto_next_end
      local goto_previous_start = move.goto_previous_start
      local goto_previous_end = move.goto_previous_end
      
      move.goto_next_start = function(query, ...)
        if vim.wo.diff then
          if query == "@function.outer" then
            vim.cmd("normal! ]c")
            return
          end
        end
        return goto_next_start(query, ...)
      end
      
      move.goto_previous_start = function(query, ...)
        if vim.wo.diff then
          if query == "@function.outer" then
            vim.cmd("normal! [c")
            return
          end
        end
        return goto_previous_start(query, ...)
      end
    end,
    opts = {
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = { 
          ["]f"] = "@function.outer", 
          ["]c"] = "@class.outer",
          ["]a"] = "@parameter.inner",
        },
        goto_next_end = { 
          ["]F"] = "@function.outer", 
          ["]C"] = "@class.outer",
          ["]A"] = "@parameter.inner",
        },
        goto_previous_start = { 
          ["[f"] = "@function.outer", 
          ["[c"] = "@class.outer",
          ["[a"] = "@parameter.inner",
        },
        goto_previous_end = { 
          ["[F"] = "@function.outer", 
          ["[C"] = "@class.outer",
          ["[A"] = "@parameter.inner",
        },
      },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  },
}
