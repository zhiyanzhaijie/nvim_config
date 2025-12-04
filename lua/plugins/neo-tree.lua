return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    -- 确保图标显示
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        default = "󰈙",
      },
    },
    window = {
      mappings = {
        -- 复制文件/文件夹
        ["<C-c>"] = function(state)
          local node = state.tree:get_node()
          if node.type == "file" or node.type == "directory" then
            local path = node:get_id()
            local clipboard = require("config.neo-tree-clipboard")
            clipboard.copy_path(path)
          end
        end,
        -- 粘贴文件/文件夹
        ["<C-v>"] = function(state)
          local clipboard = require("config.neo-tree-clipboard")
          local node = state.tree:get_node()
          
          local target_dir
          if node.type == "directory" then
            target_dir = node:get_id()
          else
            target_dir = vim.fn.fnamemodify(node:get_id(), ":h")
          end
          
          if clipboard.paste(target_dir) then
            -- 刷新 neo-tree (使用 vim.schedule 确保在安全的上下文中执行)
            vim.schedule(function()
              require("neo-tree.sources.manager").refresh("filesystem")
            end)
          end
        end,
        -- 剪切文件/文件夹
        ["<C-x>"] = function(state)
          local node = state.tree:get_node()
          if node.type == "file" or node.type == "directory" then
            local path = node:get_id()
            local clipboard = require("config.neo-tree-clipboard")
            clipboard.cut_path(path)
          end
        end,
      },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = true,
        hide_by_name = {
          ".DS_Store",
          "thumbs.db",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      group_empty_dirs = false,
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = false,
    },
  },
}
