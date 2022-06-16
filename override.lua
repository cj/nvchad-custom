local M = {}

M.lspinstaller = {
   automatic_installation = { exclude = { "solargraph", "tsserver" } },
}

local signs = { Error = "", Warn = "", Hint = "", Info = "" }

M.treesitter = {
   ensure_installed = {
      "vim",
      "html",
      "css",
      "javascript",
      "javascript",
      "json",
      "toml",
      "markdown",
      "c",
      "bash",
      "lua",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
   },
   matchup = {
      enable = true, -- mandatory, false will disable the whole extension
      disable = { "json" },
   },
   autotag = {
      enable = true,
   },
   context_commentstring = {
      enable = true,
      enable_autocmd = false,
   },
}

M.indent = {
   char = "│",
   space_char_blankline = " ",
   show_first_indent_level = true,
   filetype_exclude = {
      "startify",
      "dashboard",
      "dotooagenda",
      "log",
      "fugitive",
      "gitcommit",
      "packer",
      "vimwiki",
      "markdown",
      "txt",
      "vista",
      "help",
      "todoist",
      "NvimTree",
      "peekaboo",
      "git",
      "TelescopePrompt",
      "undotree",
      "flutterToolsOutline",
      "", -- for all buffers without a file type
   },
   buftype_exclude = { "terminal", "nofile" },
   show_trailing_blankline_indent = false,
   show_current_context = true,
   context_patterns = {
      "class",
      "function",
      "method",
      "block",
      "list_literal",
      "selector",
      "^if",
      "^table",
      "if_statement",
      "while",
      "for",
   },
}

M.nvimtree = {
   auto_reload_on_write = true,
   disable_netrw = true,
   sort_by = "name",
   renderer = {
      indent_markers = {
         enable = true,
         icons = {
            corner = "└ ",
            edge = "│ ",
            none = "  ",
         },
      },
      icons = {
         webdev_colors = true,
         padding = " ",
         symlink_arrow = " ➛ ",
         show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
         },
         glyphs = {
            default = "",
            symlink = "",
            folder = {
               default = "",
               empty = "",
               empty_open = "",
               open = "",
               symlink = "",
               symlink_open = "",
               arrow_open = "",
               arrow_closed = "",
            },
            git = {
               unstaged = "✗",
               staged = "✓",
               unmerged = "",
               renamed = "➜",
               untracked = "★",
               deleted = "",
               ignored = "◌",
            },
         },
      },
   },
   hijack_netrw = true,
   open_on_setup = false,
   ignore_ft_on_setup = {},
   open_on_tab = false,
   hijack_cursor = false,
   update_cwd = true,
   diagnostics = {
      enable = false,
      icons = {
         hint = signs.Hint,
         info = signs.Info,
         warning = signs.Warning,
         error = signs.Error,
      },
   },
   update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
   },
   system_open = {
      cmd = nil,
      args = {},
   },
   filters = {
      dotfiles = false,
      custom = {
         "^.git$",
      },
   },
   git = {
      enable = true,
      ignore = false,
      timeout = 500,
   },
   -- trash = {
   --    cmd = "trash",
   --    require_confirm = true,
   -- },
   actions = {
      change_dir = {
         global = false,
      },
      open_file = {
         quit_on_open = true,
      },
   },
   view = {
      width = 35,
      height = 30,
      hide_root_folder = true,
      side = "left",
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      mappings = {
         list = {
            { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
            { key = "<C-e>", action = "edit_in_place" },
            { key = { "O" }, action = "edit_no_picker" },
            { key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
            { key = { "<C-v>", "sg" }, action = "vsplit" },
            { key = { "<C-x>", "sv" }, action = "split" },
            { key = "<C-t>", action = "tabnew" },
            { key = "<", action = "prev_sibling" },
            { key = ">", action = "next_sibling" },
            { key = "P", action = "parent_node" },
            { key = { "l" }, action = "open_node" },
            { key = { "h", "<BS>" }, action = "close_node" },
            { key = "<Tab>", action = "preview" },
            { key = "K", action = "first_sibling" },
            { key = "J", action = "last_sibling" },
            { key = "I", action = "toggle_git_ignored" },
            { key = "H", action = "toggle_dotfiles" },
            { key = "R", action = "refresh" },
            { key = "a", action = "create" },
            { key = "d", action = "remove" },
            { key = "D", action = "trash" },
            { key = "r", action = "rename" },
            { key = "<C-r>", action = "full_rename" },
            { key = "x", action = "cut" },
            { key = "c", action = "copy" },
            { key = "p", action = "paste" },
            { key = "y", action = "copy_name" },
            { key = "Y", action = "copy_path" },
            { key = "gy", action = "copy_absolute_path" },
            { key = "[c", action = "prev_git_item" },
            { key = "]c", action = "next_git_item" },
            { key = "-", action = "dir_up" },
            { key = "..", action = "system_open" },
            { key = "q", action = "close" },
            { key = "g?", action = "toggle_help" },
            { key = "W", action = "collapse_all" },
            { key = "S", action = "search_node" },
            { key = "<C-k>", action = "toggle_file_info" },
            { key = ".", action = "run_file_command" },
         },
      },
   },
}

return M
