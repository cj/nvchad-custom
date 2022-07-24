local attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

---@diagnostic disable-next-line: different-requires
local lspconfig = require "lspconfig"
local util = lspconfig.util

local ltex = require "custom.plugins.ltex"

local servers = {
  "html",
  "cssls",
  "bashls",
  "emmet_ls",
  "clangd",
  "ltex",
  "ccls",
  "sumneko_lua",
  -- "eslint",
  "jsonls",
  "jsonnet_ls",
  "solargraph",
  "yamlls",
  "tailwindcss",
  "graphql",
  "sourcery",
  "tsserver",
  "denols",
  -- "svelte",
}

vim.cmd [[
  autocmd BufRead,BufNewFile */node_modules/* lua vim.diagnostic.disable(0)
]]

local tailwind_settings = {
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
}

local deno_file = io.open("./deno.json", "r")
if deno_file ~= nil then
  io.close(deno_file)
  lspconfig.denols.setup {
    init_options = {
      lint = true,
    },
    on_attach = function(client, bufnr)
      attach(client, bufnr)

      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.document_range_formatting = true

      require("navigator.lspclient.attach").on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  }

  lspconfig.tailwindcss.setup {
    on_attach = function(client, bufnr)
      attach(client, bufnr)

      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.document_range_formatting = true

      require("navigator.lspclient.attach").on_attach(client, bufnr)
    end,

    capabilities = capabilities,

    settings = {
      tailwindCSS = tailwind_settings,
    },
  }
  return true
end

for _, lsp in ipairs(servers) do
  local server = lspconfig[lsp]

  if lsp == "ltex" then
    ltex.override_execute_command()

    server.dictionary_file = ltex.Dictionary_file
    server.disabledrules_file = ltex.DisabledRules_file
    server.falsepostivies_file = ltex.FalsePositives_file
  end

  local root_dir = nil

  if lsp == "denols" then
    -- root_dir = util.root_pattern "deno.json"
    local f = io.open("./package.json", "r")
    if f ~= nil then
      io.close(f)
      return true
    end
  end

  if lsp == "eslint" or lsp == "tsserver" then
    local f = io.open("./deno.json", "r")
    if f ~= nil then
      io.close(f)
      return true
    end
  end

  if lsp == "solargraph" then
    root_dir = util.root_pattern("Gemfile", ".git")
  end

  server.setup {
    init_options = vim.tbl_deep_extend("force", {
      token = "user_MBPBdLmUO_nvnEkRBeZezXVCM5KND_2O0NWgPxJMLREefJptPKbLosQ0ySM",
    }, require(
      "nvim-lsp-ts-utils"
    ).init_options),

    -- root_dir = root_dir,

    settings = {
      ltex = {
        language = "en-US",
        dictionary = {
          ["en-US"] = ltex.readFiles(ltex.Dictionary_file["en-US"] or {}),
        },
        disabledRules = {
          ["en-US"] = ltex.readFiles(ltex.DisabledRules_file["en-US"] or {}),
        },
        hiddenFalsePositives = {
          ["en-US"] = ltex.readFiles(ltex.FalsePositives_file["en-US"] or {}),
        },
      },

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
        -- commandPath = "/home/cj/.asdf/shims/solargraph",
        root_dir = root_dir,
        -- root_dir = util.root_pattern("Gemfile", ".git"),
      },

      -- grammarly = {
      --    root_dir = util.root_pattern("Gemfile", ".git"),
      -- },

      -- tailwindCSS = tailwind_settings,
    },

    on_attach = function(client, bufnr)
      attach(client, bufnr)

      vim.diagnostic.config {
        virtual_text = false,
      }

      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.document_range_formatting = true

      -- if not lsp == "tsserver" then
      --    client.server_capabilities.renameProvider = false
      -- end

      -- require("navigator.lspclient.attach").on_attach(client, bufnr)

      vim.cmd [[
               autocmd BufRead,BufNewFile */node_modules/* lua require("navigator.lspclient.attach").on_attach(client, bufnr)
            ]]

      -- if lsp == "eslint" then
      --   client.resolved_capabilities.document_formatting = false
      --   client.resolved_capabilities.document_range_formatting = false
      -- end

      if lsp == "tsserver" or lsp == "jsonls" then
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
      end

      if lsp == "tsserver" then
        local ts_utils = require "nvim-lsp-ts-utils"
        --
        -- -- defaults
        ts_utils.setup {
          debug = false,
          disable_commands = false,
          enable_import_on_completion = false,

          -- import all
          import_all_timeout = 5000, -- ms
          -- lower numbers = higher priority
          import_all_priorities = {
            same_file = 1, -- add to existing import statement
            local_files = 2, -- git files or files with relative path markers
            buffer_content = 3, -- loaded buffer content
            buffers = 4, -- loaded buffer names
          },
          import_all_scan_buffers = 100,
          import_all_select_source = false,
          -- if false will avoid organizing imports
          always_organize_imports = true,

          -- filter diagnostics
          filter_out_diagnostics_by_severity = {},
          filter_out_diagnostics_by_code = {},
          eslint_enable_diagnostics = true,

          -- inlay hints
          auto_inlay_hints = false,
          inlay_hints_highlight = "Comment",
          inlay_hints_priority = 200, -- priority of the hint extmarks
          inlay_hints_throttle = 150, -- throttle the inlay hint request
          inlay_hints_format = { -- format options for individual hint kind
            Type = {},
            Parameter = {},
            Enum = {},
            -- Example format customization for `Type` kind:
            -- Type = {
            --     highlight = "Comment",
            --     text = function(text)
            --         return "->" .. text:sub(2)
            --     end,
            -- },
          },

          -- update imports on file move
          update_imports_on_move = true,
          require_confirmation_on_move = false,
          watch_dir = true,
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
