return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("monoglow").load()
      end,
    },
  },
  {
    "wnkz/monoglow.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(highlights, colors)
        -- 将 string 的颜色改为 "#95aa67"
        highlights.String = { fg = "#95aa67" }
        highlights["@string"] = { fg = "#95aa67" }
        highlights["@string.documentation"] = { fg = "#95aa67" }
        highlights["@string.regex"] = { fg = "#95aa67" }
        highlights["@string.escape"] = { fg = "#95aa67" }
        
        -- 将数字的颜色改为和 boolean 一样 (blue2: "#66b2b2")
        highlights.Number = { fg = colors.blue2 }
        highlights.Float = { fg = colors.blue2 }
        highlights["@number"] = { fg = colors.blue2 }
        highlights["@number.float"] = { fg = colors.blue2 }
      end,
    },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.g.gruvbox_material_enable_italic = false
      -- vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      no_italic = true,
      term_colors = true,
      transparent_background = false,
      styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
      },
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
      integrations = {
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        dropbar = {
          enabled = true,
          color_mode = true,
        },
        neo_tree = {
          enabled = true,
        },
      },
    },
  },
}
