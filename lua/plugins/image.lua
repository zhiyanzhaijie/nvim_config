return {
  {
    "3rd/image.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = function()

      return {
        backend = "kitty",
        processor = "magick_cli",
        integrations = {
          markdown = {
            enabled = true,
            download_remote_images = true,
            only_render_image_at_cursor = false,
          },
        },
        max_width = 100,
        max_height = 12,
        max_width_window_percentage = math.huge,
        max_height_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      }
    end,
  },
}
