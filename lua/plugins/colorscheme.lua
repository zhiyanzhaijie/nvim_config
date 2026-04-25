return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("catppuccin").load()
        -- require("monoglow").load()
      end,
    },
  },
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_enable_italic = true
    end,
  },
  {
    "wnkz/monoglow.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(highlights, colors)
        highlights.String = { fg = "#95aa67" }
        highlights["@string"] = { fg = "#95aa67" }
        highlights["@string.documentation"] = { fg = "#95aa67" }
        highlights["@string.regex"] = { fg = "#95aa67" }
        highlights["@string.escape"] = { fg = "#95aa67" }

        highlights.Number = { fg = colors.blue2 }
        highlights.Float = { fg = colors.blue2 }
        highlights["@number"] = { fg = colors.blue2 }
        highlights["@number.float"] = { fg = colors.blue2 }
      end,
    },
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
        macchiato = {},
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
        latte = {
          base = "#fafafa",
          mantle = "#ebebec",
          crust = "#dcdcdd",

          text = "#242529",
          subtext1 = "#58585a",
          subtext0 = "#7e8086",

          overlay2 = "#a3a3a4",
          overlay1 = "#b4b4bb",
          overlay0 = "#c9c9ca",

          surface2 = "#dfdfe0",
          surface1 = "#ebebec",
          surface0 = "#fafafa",

          blue = "#5b79e3",
          red = "#de3e35",
          green = "#649f57",
          yellow = "#c18401",
          peach = "#ad6e25",
          mauve = "#a449ab",
          teal = "#3882b7",
          lavender = "#5c78e2",
          sky = "#3882b7",
          rosewater = "#d3604f",
          flamingo = "#d3604f",
          maroon = "#b92b46",
        },
      },
      highlight_overrides = {
        macchiato = function(macchiato)
          return {}
        end,
        latte = function(latte)
          return {
            ["@namespace"] = { fg = latte.text },
            ["@type"] = { fg = latte.blue },
            ["@type.builtin"] = { fg = latte.blue },
            ["@type.definition"] = { fg = latte.blue },
            ["@property"] = { fg = latte.rosewater },
            ["@variable.member"] = { fg = latte.rosewater }, -- For newer treesitter versions
            ["@field"] = { fg = latte.rosewater },
            ["@constructor"] = { fg = latte.blue },
          }
        end,
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
