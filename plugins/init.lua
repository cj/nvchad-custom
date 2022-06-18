-- then load your mappings
local jsfiles = { "javascript", "typescript", "javascriptreact", "typescriptreact", "graphql" }

return {
  ["SmiteshP/nvim-gps"] = {
    event = "CursorMoved",
    config = function()
      require "custom.plugins.gps"
    end,
  },

  ["sindrets/diffview.nvim"] = {
    after = "plenary.nvim",
    requires = "nvim-lua/plenary.nvim",
    -- config = function()
    --    require "custom.plugins.diffview"
    -- end,
  },

  ["pwntester/octo.nvim"] = {
    after = { "plenary.nvim", "telescope.nvim", "nvim-treesitter" },
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    setup = function()
      -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      -- parser_config.markdown.filetype_to_parsername = "octo"
      vim.api.nvim_buf_set_keymap(0, "i", "@", "@<C-x><C-o>", { silent = true, noremap = true })
      vim.api.nvim_buf_set_keymap(0, "i", "#", "#<C-x><C-o>", { silent = true, noremap = true })
    end,
    config = function()
      require("octo").setup {
        default_remote = { "upstream", "origin" }, -- order to try remotes
        ssh_aliases = {}, -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
        reaction_viewer_hint_icon = "", -- marker for user reactions
        user_icon = " ", -- user icon
        timeline_marker = "", -- timeline marker
        timeline_indent = "2", -- timeline indentation
        right_bubble_delimiter = "", -- Bubble delimiter
        left_bubble_delimiter = "", -- Bubble delimiter
        github_hostname = "", -- GitHub Enterprise host
        snippet_context_lines = 4, -- number or lines around commented lines
        file_panel = {
          size = 10, -- changed files panel rows
          use_icons = true, -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
        },
        mappings = {
          issue = {
            close_issue = { lhs = "<C-space>ic", desc = "close issue" },
            reopen_issue = { lhs = "<C-space>io", desc = "reopen issue" },
            list_issues = { lhs = "<C-space>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-r>", desc = "reload issue" },
            open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            add_assignee = { lhs = "<C-space>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<C-space>ad", desc = "remove assignee" },
            create_label = { lhs = "<C-space>lc", desc = "create label" },
            add_label = { lhs = "<C-space>la", desc = "add label" },
            remove_label = { lhs = "<C-space>ld", desc = "remove label" },
            goto_issue = { lhs = "<C-space>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<C-space>ca", desc = "add comment" },
            delete_comment = { lhs = "<C-space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<C-space>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<C-space>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<C-space>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<C-space>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<C-space>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<C-space>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<C-space>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<C-space>rc", desc = "add/remove 😕 reaction" },
          },
          pull_request = {
            checkout_pr = { lhs = "<C-space>po", desc = "checkout PR" },
            merge_pr = { lhs = "<C-space>pm", desc = "merge commit PR" },
            squash_and_merge_pr = { lhs = "<C-space>psm", desc = "squash and merge PR" },
            list_commits = { lhs = "<C-space>pc", desc = "list PR commits" },
            list_changed_files = { lhs = "<C-space>pf", desc = "list PR changed files" },
            show_pr_diff = { lhs = "<C-space>pd", desc = "show PR diff" },
            add_reviewer = { lhs = "<C-space>va", desc = "add reviewer" },
            remove_reviewer = { lhs = "<C-space>vd", desc = "remove reviewer request" },
            close_issue = { lhs = "<C-space>ic", desc = "close PR" },
            reopen_issue = { lhs = "<C-space>io", desc = "reopen PR" },
            list_issues = { lhs = "<C-space>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-r>", desc = "reload PR" },
            open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            goto_file = { lhs = "gf", desc = "go to file" },
            add_assignee = { lhs = "<C-space>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<C-space>ad", desc = "remove assignee" },
            create_label = { lhs = "<C-space>lc", desc = "create label" },
            add_label = { lhs = "<C-space>la", desc = "add label" },
            remove_label = { lhs = "<C-space>ld", desc = "remove label" },
            goto_issue = { lhs = "<C-space>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<C-space>ca", desc = "add comment" },
            delete_comment = { lhs = "<C-space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<C-space>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<C-space>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<C-space>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<C-space>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<C-space>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<C-space>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<C-space>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<C-space>rc", desc = "add/remove 😕 reaction" },
          },
          review_thread = {
            goto_issue = { lhs = "<C-space>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<C-space>ca", desc = "add comment" },
            add_suggestion = { lhs = "<C-space>sa", desc = "add suggestion" },
            delete_comment = { lhs = "<C-space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            react_hooray = { lhs = "<C-space>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<C-space>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<C-space>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<C-space>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<C-space>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<C-space>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<C-space>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<C-space>rc", desc = "add/remove 😕 reaction" },
          },
          submit_win = {
            approve_review = { lhs = "<C-a>", desc = "approve review" },
            comment_review = { lhs = "<C-m>", desc = "comment review" },
            request_changes = { lhs = "<C-r>", desc = "request changes review" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          },
          review_diff = {
            add_review_comment = { lhs = "<C-space>ca", desc = "add a new review comment" },
            add_review_suggestion = { lhs = "<C-space>sa", desc = "add a new review suggestion" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            next_thread = { lhs = "]t", desc = "move to next thread" },
            prev_thread = { lhs = "[t", desc = "move to previous thread" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
          },
          file_panel = {
            next_entry = { lhs = "j", desc = "move to next changed file" },
            prev_entry = { lhs = "k", desc = "move to previous changed file" },
            select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
            refresh_files = { lhs = "R", desc = "refresh changed files panel" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
          },
        },
      }
    end,
  },

  ["tpope/vim-abolish"] = {},

  ["isobit/vim-caddyfile"] = {},

  ["nvim-treesitter/nvim-treesitter-refactor"] = {},

  ["numToStr/Comment.nvim"] = {
    module = "Comment",
    keys = { "gc", "gb" },

    config = function()
      local present, nvim_comment = pcall(require, "Comment")

      if not present then
        return
      end

      nvim_comment.setup {
        pre_hook = function(ctx)
          local U = require "Comment.utils"

          local location = nil
          if ctx.ctype == U.ctype.block then
            location = require("ts_context_commentstring.utils").get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
          end

          return require("ts_context_commentstring.internal").calculate_commentstring {
            key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
            location = location,
          }
        end,
      }
    end,
  },

  ["JoosepAlviste/nvim-ts-context-commentstring"] = {},

  ["AckslD/nvim-neoclip.lua"] = {
    after = "telescope.nvim",
    requires = {
      { "tami5/sqlite.lua", module = "sqlite" },
    },
    config = function()
      require("neoclip").setup {
        history = 1000,
        enable_persistent_history = true,
        db_path = vim.fn.stdpath "data" .. "/databases/neoclip.sqlite3",
        filter = nil,
        preview = true,
        default_register = '"',
        content_spec_column = false,
        dynamic_preview_title = true,
        on_paste = {
          set_reg = false,
        },
        keys = {
          telescope = {
            i = {
              select = "<cr>",
              paste = "<c-p>",
              paste_behind = "<c-P>",
              custom = {},
            },
            n = {
              select = "<cr>",
              paste = "p",
              paste_behind = "P",
              custom = {},
            },
          },
          fzf = {
            select = "default",
            paste = "ctrl-p",
            paste_behind = "ctrl-k",
            custom = {},
          },
        },
      }

      require("telescope").load_extension "neoclip"
    end,
  },

  ["nvim-telescope/telescope.nvim"] = {
    cmd = "Telescope",
    config = function()
      require "custom.plugins.telescope"
    end,
    setup = function()
      -- load extensions
      local extensions = { "neoclip" }
      local present, telescope = pcall(require, "telescope")

      if not present then
        return
      end

      pcall(function()
        for _, ext in ipairs(extensions) do
          telescope.load_extension(ext)
        end
      end)
    end,
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end,
  },

  -- ["nvim-telescope/telescope-media-files.nvim"] = {
  --    after = "telescope.nvim",
  --    config = function()
  --       require("telescope").load_extension "media_files"
  --    end,
  -- },

  ["RRethy/vim-illuminate"] = {},

  ["Pocco81/TrueZen.nvim"] = {
    cmd = {
      "TZAtaraxis",
      "TZMinimalist",
      "TZFocus",
    },
    config = function()
      require "custom.plugins.truezen"
    end,
  },

  ["christoomey/vim-tmux-navigator"] = {},

  ["github/copilot.vim"] = {},

  ["cj/guihua.lua"] = {
    run = "cd lua/fzy && make",
    config = function()
      require("guihua.maps").setup {
        maps = {
          prev = "<C-k>",
          next = "<C-j>",
        },
      }
    end,
  },

  ["jose-elias-alvarez/nvim-lsp-ts-utils"] = {},

  ["phaazon/hop.nvim"] = {
    event = "BufEnter",
    branch = "v1", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup {}
    end,
  },

  ["brooth/far.vim"] = {},

  ["editorconfig/editorconfig"] = { event = "InsertEnter" },

  ["slim-template/vim-slim"] = { ft = { "slim" } },

  ["mg979/vim-visual-multi"] = { branch = "master", event = "InsertEnter" },

  ["jparise/vim-graphql"] = { event = "InsertEnter", ft = jsfiles },

  ["windwp/nvim-ts-autotag"] = { ft = jsfiles, after = "nvim-treesitter" },

  ["kchmck/vim-coffee-script"] = { ft = "coffee" },

  ["folke/trouble.nvim"] = {
    requires = "kyazdani42/nvim-web-devicons",
    event = "BufEnter",
    config = function()
      require("trouble").setup {
        use_diagnostic_signs = true,
      }
    end,
  },

  ["hrsh7th/nvim-cmp"] = {
    after = "friendly-snippets",
    config = function()
      require "custom.plugins.cmp" -- must be right path
    end,
  },

  ["tzachar/cmp-tabnine"] = {
    after = "nvim-cmp",
    requires = "hrsh7th/nvim-cmp",
    run = "./install.sh",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 5,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
      }
    end,
  },

  ["hrsh7th/cmp-copilot"] = { after = "nvim-cmp" },

  ["mbbill/undotree"] = {},

  ["easymotion/vim-easymotion"] = {
    event = "BufEnter",
    config = function() end,
  },

  ["rcarriga/nvim-notify"] = {
    config = function()
      vim.notify = require "notify"
    end,
  },

  ["folke/todo-comments.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to the default settings
        -- refer to the configuration section below
      }
    end,
  },

  ["ray-x/navigator.lua"] = {
    after = "nvim-lspconfig",
    config = function()
      require("navigator").setup {
        default_mapping = false,
        -- keymaps = {
        --    { key = "K", func = "vim.lsp.buf.hover()" },
        --    { key = "M", mode = "n", func = "require('navigator.codeAction').code_action()" },
        -- },
        lsp_installer = true,
        lsp_signature_help = true,
        lsp = {
          disable_lsp = {
            "denols",
          },
          format_on_save = false,
          diagnostic = {
            underline = true,
            virtual_text = false, -- show virtual for diagnostic message
            update_in_insert = false, -- update diagnostic message in insert mode
          },
          diagnostic_virtual_text = false,
          code_action = {
            enable = true,
            sign = true,
            sign_priority = 40,
            virtual_text = false,
          },
          code_lens_action = {
            enable = true,
            sign = true,
            sign_priority = 20,
            virtual_text = false,
          },
        },
      }

      vim.cmd [[
           " hi default GHTextViewDark guifg=#e0d8f4 guibg=#332e55
           " hi default GHListDark guifg=#e0d8f4 guibg=#103234
           " hi default GHListHl guibg=#404254
         ]]
    end,
  },
}
