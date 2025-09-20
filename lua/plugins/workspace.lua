return {
  "natecraddock/workspaces.nvim",
  event = "VeryLazy",
  config = function()
    require("workspaces").setup({
      hooks = {
        open = "Telescope find_files",
      },
    })

    require("telescope").load_extension("workspaces")
  end,

  keys = {
    { "<leader>ps", "<cmd>Telescope workspaces<cr>", desc = "workspace - switch" },
    { "<leader>pa", "<cmd>WorkspacesAdd<cr>", desc = "workspace - add" },
    { "<leader>pr", "<cmd>WorkspacesRemove<cr>", desc = "workspace - remove" },
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
