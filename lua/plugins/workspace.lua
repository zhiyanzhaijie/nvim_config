return {
  "natecraddock/workspaces.nvim",
  event = "VeryLazy",
  config = function()
    -- 清理无效的workspace（路径不存在的）
    local cleanup_invalid_workspaces = function()
      local workspaces_module = require("workspaces")
      local workspaces = workspaces_module.get()
      local removed_count = 0

      for _, workspace in ipairs(workspaces) do
        if vim.fn.isdirectory(workspace.path) == 0 then
          workspaces_module.remove(workspace.name)
          removed_count = removed_count + 1
          vim.notify(
            string.format("Removed invalid workspace: %s -> %s", workspace.name, workspace.path),
            vim.log.levels.INFO
          )
        end
      end

      if removed_count == 0 then
        vim.notify("No invalid workspaces found", vim.log.levels.INFO)
      else
        vim.notify(string.format("Cleaned up %d invalid workspace(s)", removed_count), vim.log.levels.INFO)
      end
    end

    -- 创建清理命令
    vim.api.nvim_create_user_command("WorkspacesCleanup", cleanup_invalid_workspaces, {
      desc = "Remove all workspaces with non-existent paths",
    })

    require("workspaces").setup({
      hooks = {
        open = "Telescope find_files",
      },
    })

    require("telescope").load_extension("workspaces")
  end,

  keys = {
    {
      "<leader>ps",
      function()
        -- 在显示前先自动清理无效的workspaces
        local workspaces_module = require("workspaces")
        local workspaces = workspaces_module.get()
        local valid_workspaces = {}

        for _, workspace in ipairs(workspaces) do
          if vim.fn.isdirectory(workspace.path) == 1 then
            table.insert(valid_workspaces, workspace)
          else
            -- 静默删除无效的workspace
            workspaces_module.remove(workspace.name)
          end
        end

        if #valid_workspaces == 0 then
          vim.notify("No valid workspaces found", vim.log.levels.WARN)
          return
        end

        -- 显示telescope选择器
        vim.cmd("Telescope workspaces")
      end,
      desc = "workspace - switch",
    },
    { "<leader>pa", "<cmd>WorkspacesAdd<cr>", desc = "workspace - add" },
    {
      "<leader>pr",
      function()
        local workspaces_module = require("workspaces")
        local workspaces = workspaces_module.get()

        if #workspaces == 0 then
          vim.notify("No workspaces found", vim.log.levels.WARN)
          return
        end

        -- 使用 telescope 进行选择，并显示路径是否有效
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local conf = require("telescope.config").values

        pickers
          .new({}, {
            prompt_title = "Select workspace to remove",
            finder = finders.new_table({
              results = workspaces,
              entry_maker = function(entry)
                local valid_marker = vim.fn.isdirectory(entry.path) == 1 and "✓" or "✗"
                return {
                  value = entry,
                  display = string.format("%s %s -> %s", valid_marker, entry.name, entry.path),
                  ordinal = entry.name .. " " .. entry.path,
                }
              end,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                if selection then
                  local workspace = selection.value
                  workspaces_module.remove(workspace.name)
                  vim.notify(
                    string.format("Removed workspace: %s -> %s", workspace.name, workspace.path),
                    vim.log.levels.INFO
                  )
                end
              end)
              return true
            end,
          })
          :find()
      end,
      desc = "workspace - remove",
    },
    {
      "<leader>pc",
      "<cmd>WorkspacesCleanup<cr>",
      desc = "workspace - cleanup invalid",
    },
    {
      "<leader>pn",
      function()
        local workspaces = require("workspaces").get()
        if #workspaces == 0 then
          vim.notify("No workspaces found", vim.log.levels.WARN)
          return
        end

        -- 使用 telescope 进行选择，更可靠
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local conf = require("telescope.config").values

        pickers
          .new({}, {
            prompt_title = "Select workspace to rename",
            finder = finders.new_table({
              results = workspaces,
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = entry.name .. " -> " .. entry.path,
                  ordinal = entry.name .. " " .. entry.path,
                }
              end,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                if selection then
                  local workspace = selection.value
                  local new_name = vim.fn.input("New name for '" .. workspace.name .. "': ")
                  if new_name and new_name ~= "" then
                    require("workspaces").rename(workspace.name, new_name)
                  end
                end
              end)
              return true
            end,
          })
          :find()
      end,
      desc = "workspace - rename",
    },
  },

  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
}
