local M = {}

M.setup_lsp = function(attach, capabilities)
   local util = require "lspconfig.util"
   local lspconfig = require "lspconfig"

   local servers = {
      "html",
      "cssls",
      "bashls",
      "emmet_ls",
      "clangd",
      "ccls",
      "sumneko_lua",
      "eslint",
      "jsonls",
      "pyright",
      "pylsp",
      "solargraph",
      "spectral",
      "yamlls",
      "tailwindcss",
      "graphql",
      "sourcery",
      "tsserver",
   }

   for _, lsp in ipairs(servers) do
      local server = lspconfig[lsp]

      server.setup {
         init_options = {
            token = "user_MBPBdLmUO_nvnEkRBeZezXVCM5KND_2O0NWgPxJMLREefJptPKbLosQ0ySM",
         },
         settings = {
            solargraph = {
               autoformat = true,
               diagnostics = true,
               completion = true,
               useBundler = true,
               diagnostic = true,
               folding = true,
               references = true,
               rename = true,
               symbols = true,
               commandPath = "/home/cj/.asdf/shims/solargraph",
               root_dir = util.root_pattern("Gemfile", ".git"),
            },
            tailwindCSS = {
               lint = {
                  cssConflict = "warning",
                  invalidApply = "error",
                  invalidConfigPath = "error",
                  invalidScreen = "error",
                  invalidTailwindDirective = "error",
                  invalidVariant = "error",
                  recommendedVariantOrder = "warning",
               },
               validate = true,
               experimental = {
                  classRegex = { "tw\\.\\w+`([^`]*)" },
               },
            },
         },

         on_attach = function(client, bufnr)
            attach(client, bufnr)

            client.resolved_capabilities.document_formatting = true
            client.resolved_capabilities.document_range_formatting = true

            -- if not lsp == "tsserver" then
            --    client.server_capabilities.renameProvider = false
            -- end

            require("navigator.lspclient.attach").on_attach(client, bufnr)

            -- if lsp == "eslint" then
            --    client.resolved_capabilities.document_formatting = false
            --    client.resolved_capabilities.document_range_formatting = false
            -- end

            if lsp == "tsserver" then
               -- client.resolved_capabilities.document_formatting = false
               -- client.resolved_capabilities.document_range_formatting = false

               local ts_utils = require "nvim-lsp-ts-utils"
               --
               -- -- defaults
               ts_utils.setup {
                  debug = false,
                  disable_commands = false,
                  enable_import_on_completion = true,

                  -- import all
                  import_all_timeout = 5000, -- ms
                  -- lower numbers indicate higher priority
                  import_all_priorities = {
                     same_file = 1, -- add to existing import statement
                     local_files = 2, -- git files or files with relative path markers
                     buffer_content = 3, -- loaded buffer content
                     buffers = 4, -- loaded buffer names
                  },
                  -- import_all_scan_buffers = 100,
                  -- import_all_select_source = false,

                  -- eslint
                  eslint_enable_code_actions = true,
                  eslint_enable_disable_comments = true,
                  eslint_bin = "eslint_d",
                  eslint_enable_diagnostics = true,
                  eslint_enable_formatting = true,
                  eslint_opts = {},

                  -- formatting
                  enable_formatting = true,
                  formatter = "prettierd",
                  formatter_opts = {},

                  -- update imports on file move
                  update_imports_on_move = true,
                  require_confirmation_on_move = false,
                  watch_dir = nil,

                  -- filter diagnostics
                  filter_out_diagnostics_by_severity = {},
                  filter_out_diagnostics_by_code = {},

                  -- inlay hints
                  auto_inlay_hints = false,
               }
               --
               -- -- required to fix code action ranges and filter diagnostics
               ts_utils.setup_client(client)
               --
               -- -- no default maps, so you may want to define some here
               -- local opts = { silent = true }
            end
         end,

         capabilities = capabilities,
      }
   end
end

return M
