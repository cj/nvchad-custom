local present, telescope = pcall(require, "telescope")

if not present then
   return
end

vim.g.theme_switcher_loaded = true

require("base46").load_highlight "telescope"

local actions = require "telescope.actions"

local options = {
   defaults = {
      vimgrep_arguments = {
         "rg",
         "--color=never",
         "--no-heading",
         "--with-filename",
         "--line-number",
         "--column",
         "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "vertical",
      layout_config = {
         vertical = {
            prompt_position = "bottom",
            mirror = true,
         },
         preview_cutoff = 35,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = true,
      borderchars = {
         prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
         results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
         preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
         -- height = 25,
      },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
         i = {
            ["<C-c>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            -- ["<c-t>"] = trouble.open_with_trouble,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            -- To disable a keymap, put [map] = false
            -- So, to not map "<C-n>", just put
            -- ["<c-x>"] = false,
            -- ["<esc>"] = actions.close,

            -- Otherwise, just set the mapping to the function that you want it to be.
            -- ["<C-i>"] = actions.select_horizontal,

            -- Add up multiple actions
            ["<CR>"] = actions.select_default + actions.center,

            -- You can perform as many actions in a row as you like
            -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
         },
         n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            -- ["<c-t>"] = trouble.open_with_trouble,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            -- ["<C-i>"] = my_cool_custom_action,
         },
      },
   },

   extensions_list = { "themes", "terms", "neoclip" },
}

-- check for any override
options = require("core.utils").load_override(options, "nvim-telescope/telescope.nvim")
telescope.setup(options)

-- load extensions
pcall(function()
   for _, ext in ipairs(options.extensions_list) do
      print("Loading extension: " .. ext)
      telescope.load_extension(ext)
   end
end)
