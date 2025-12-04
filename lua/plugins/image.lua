-- 图片预览配置
-- 使用终端工具显示图片

return {
  -- 自定义图片预览功能
  {
    "nvim-lua/plenary.nvim", -- 只需要这个依赖
    config = function()
      -- 创建图片预览自动命令
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg", "*.bmp", "*.tiff", "*.ico" },
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          
          -- 如果标记为跳过预览，则不执行预览逻辑
          if vim.b.skip_image_preview then
            return
          end
          
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
            "  v  - 使用系统默认程序打开",
            "  e  - 编辑源代码 (SVG/XML)",
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
            -- 使用系统默认程序打开
            if vim.fn.has("mac") == 1 then
              vim.fn.system("open '" .. filepath .. "' &")
            else
              vim.fn.system("xdg-open '" .. filepath .. "' &")
            end
          end, "系统默认程序")

          set_keymap("r", function()
            vim.cmd("edit!")
          end, "重新加载")

          set_keymap("e", function()
            -- 切换到源代码编辑模式
            -- 标记缓冲区跳过预览模式
            vim.b.skip_image_preview = true
            
            -- 删除预览模式的键位绑定
            vim.keymap.del("n", "q", { buffer = buf })
            vim.keymap.del("n", "v", { buffer = buf })
            vim.keymap.del("n", "r", { buffer = buf })
            vim.keymap.del("n", "e", { buffer = buf })
            
            -- 设置为可编辑
            vim.api.nvim_buf_set_option(buf, "modifiable", true)
            vim.api.nvim_buf_set_option(buf, "readonly", false)
            
            -- 读取文件内容
            vim.cmd("edit!")
            
            -- 设置为 xml/svg 语法高亮
            vim.api.nvim_buf_set_option(buf, "filetype", "xml")
            
            -- 确保可编辑（edit! 后再次设置）
            vim.api.nvim_buf_set_option(buf, "modifiable", true)
            vim.api.nvim_buf_set_option(buf, "readonly", false)
            
            -- 恢复编辑器选项
            vim.opt_local.number = true
            vim.opt_local.relativenumber = true
            
            -- 添加 Esc 返回预览模式的键位绑定
            vim.keymap.set("n", "<Esc>", function()
              -- 保存文件
              vim.cmd("write")
              -- 清除跳过标记
              vim.b.skip_image_preview = false
              -- 重新加载以触发预览
              vim.cmd("edit!")
            end, { buffer = buf, desc = "返回预览模式", silent = true })
          end, "编辑源代码")
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

