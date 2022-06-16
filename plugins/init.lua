-- then load your mappings
local jsfiles = { "javascript", "typescript", "javascriptreact", "typescriptreact", "graphql" }

return {
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
                  "solargraph",
                  "pyright",
                  "yamlls",
                  "graphql",
                  "tsserver",
                  "jsonls",
                  "eslint",
                  "tailwindcss",
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
