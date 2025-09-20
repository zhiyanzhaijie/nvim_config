-- 图片预览配置
-- 使用终端工具显示图片

return {
  -- 自定义图片预览功能
  {
    "nvim-lua/plenary.nvim", -- 只需要这个依赖
    config = function()
      -- 创建图片预览自动命令
      vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
        pattern = {"*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg", "*.bmp", "*.tiff", "*.ico"},
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          local filepath = vim.api.nvim_buf_get_name(buf)
          
          -- 清除缓冲区内容并设置为只读
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
          vim.api.nvim_buf_set_option(buf, "readonly", true)
          vim.api.nvim_buf_set_option(buf, "modifiable", false)
          vim.api.nvim_buf_set_option(buf, "filetype", "image")
          
          -- 获取文件信息
          local file_stat = vim.loop.fs_stat(filepath)
          local file_size = file_stat and file_stat.size or 0
          local file_size_str = ""
          if file_size > 1024 * 1024 then
            file_size_str = string.format("%.1f MB", file_size / 1024 / 1024)
          elseif file_size > 1024 then
            file_size_str = string.format("%.1f KB", file_size / 1024)
          else
            file_size_str = string.format("%d bytes", file_size)
          end
          
          local info_text = {
            "📸 图片文件预览",
            "",
            "🗂️  文件名: " .. vim.fn.fnamemodify(filepath, ":t"),
            "📁 路径: " .. filepath,
            "📊 大小: " .. file_size_str,
            "🔧 格式: " .. vim.fn.fnamemodify(filepath, ":e"):upper(),
            "",
            "🎯 可用操作:",
            "  v  - 使用外部查看器打开",
            "  c  - 使用 chafa 在终端显示 (ASCII 艺术)",
            "  f  - 使用系统默认程序打开", 
            "  q  - 退出",
            "  r  - 重新加载",
            "",
            "💡 提示: 按相应按键执行操作",
          }
          
          vim.api.nvim_buf_set_option(buf, "modifiable", true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, info_text)
          vim.api.nvim_buf_set_option(buf, "modifiable", false)
          
          -- 设置键位绑定
          local function set_keymap(key, cmd, desc)
            vim.keymap.set("n", key, cmd, { buffer = buf, desc = desc, silent = true })
          end
          
          set_keymap("q", "<cmd>q<cr>", "退出")
          
          set_keymap("v", function()
            if vim.fn.executable("feh") == 1 then
              vim.fn.system("feh '" .. filepath .. "' &")
            elseif vim.fn.executable("eog") == 1 then
              vim.fn.system("eog '" .. filepath .. "' &")
            elseif vim.fn.executable("gwenview") == 1 then
              vim.fn.system("gwenview '" .. filepath .. "' &")
            else
              vim.notify("未找到图片查看器 (feh, eog, gwenview)", vim.log.levels.WARN)
            end
          end, "外部查看器")
          
          set_keymap("c", function()
            if vim.fn.executable("chafa") == 1 then
              -- 在终端中显示 ASCII 艺术
              local cmd = string.format("chafa --size=%dx%d '%s'", vim.o.columns - 2, vim.o.lines - 4, filepath)
              vim.api.nvim_buf_set_option(buf, "modifiable", true)
              
              local output = vim.fn.systemlist(cmd)
              local display_lines = vim.list_extend({
                "📸 " .. vim.fn.fnamemodify(filepath, ":t") .. " (ASCII 预览)",
                "按 'r' 重新加载, 'q' 退出, 'v' 使用外部查看器",
                ""
              }, output)
              
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, display_lines)
              vim.api.nvim_buf_set_option(buf, "modifiable", false)
            else
              vim.notify("需要安装 chafa: sudo pacman -S chafa", vim.log.levels.WARN)
            end
          end, "终端 ASCII 预览")
          
          set_keymap("f", function()
            vim.fn.system("xdg-open '" .. filepath .. "' &")
          end, "系统默认程序")
          
          set_keymap("r", function()
            vim.cmd("edit!")
          end, "重新加载")
          
        end,
      })
      
      -- 创建图片文件类型
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "image",
        callback = function()
          vim.opt_local.wrap = false
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = "no"
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.colorcolumn = ""
        end,
      })
    end,
  },
}