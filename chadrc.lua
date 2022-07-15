local M = {}

local override = require "custom.override"
local userPlugins = require "custom.plugins"

M.plugins = {
   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },

      statusline = {
         -- separator_style = "round",
      },
   },

   override = {
      ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
      ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
      ["williamboman/nvim-lsp-installer"] = override.lspinstaller,
      ["lukas-reineke/indent-blankline.nvim"] = override.indent,
      ["NvChad/ui"] = {
         statusline = {
            overriden_modules = function()
               return require "custom.plugins.statusline"
            end,
         },
      },
   },

   user = userPlugins,
}

M.options = {
   user = function()
      vim.o.completeopt = "menu,menuone,noselect"

      vim.g.mapleader = ";"

      vim.api.nvim_create_autocmd("BufWritePre", {
         callback = function()
            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
            vim.lsp.buf.formatting_seq_sync(nil, 10000)
         end,
      })
   end,
}

M.mappings = require "custom.mappings"

M.ui = {
   -- statusline = {
   --  override = require "custom.plugins.statusline",
   -- },

   hl_override = {
      --override default highlights
      IndentBlanklineContextChar = { fg = "#e5c07b", bg = "NONE" },
      IndentBlanklineContextStart = { fg = "NONE", bg = "#272c36" },
      -- DiffAdd = { bg = "#23384c", fg = "" },
      DiffAdd = { bg = "#2F4446", fg = "NONE" },
      DiffChange = { bg = "#232c4c", fg = "NONE" },
      DiffText = { bg = "#404475", fg = "NONE" },
      -- DiffDelete = { bg = "", fg = "#313650" },
      DiffDelete = { bg = "#341c28", fg = "#313650" },
   },

   hl_add = {
      DiffText = { bg = "#404475", fg = "NONE" },
      -- Gps item kinds
      GpsItemAbbr = { fg = "#abb2bf", bg = "#22262e", bold = true },
      GpsItemAbbrMatch = { fg = "#61afef", bold = true, bg = "#22262e" },
      GpsBorder = { fg = "#42464e", bg = "#22262e", bold = true },
      GpsDocBorder = { fg = "#42464e", bg = "#22262e", bold = true },
      GpsItemKindConstant = { fg = "#d19a66", bg = "#22262e", bold = true },
      GpsItemKindFunction = { fg = "#61afef", bg = "#22262e", bold = true },
      GpsItemKindIdentifier = { fg = "#e06c75", bg = "#22262e", bold = true },
      GpsItemKindField = { fg = "#e06c75", bg = "#22262e", bold = true },
      GpsItemKindVariable = { fg = "#c678dd", bg = "#22262e", bold = true },
      GpsItemKindSnippet = { fg = "#e06c75", bg = "#22262e", bold = true },
      GpsItemKindText = { fg = "#98c379", bg = "#22262e", bold = true },
      GpsItemKindStructure = { fg = "#c678dd", bg = "#22262e", bold = true },
      GpsItemKindType = { fg = "#e5c07b", bg = "#22262e", bold = true },
      GpsItemKindKeyword = { fg = "#c8ccd4", bg = "#22262e", bold = true },
      GpsItemKindMethod = { fg = "#61afef", bg = "#22262e", bold = true },
      GpsItemKindConstructor = { fg = "#61afef", bg = "#22262e", bold = true },
      GpsItemKindFolder = { fg = "#c8ccd4", bg = "#22262e", bold = true },
      GpsItemKindModule = { fg = "#e5c07b", bg = "#22262e", bold = true },
      GpsItemKindProperty = { fg = "#e06c75", bg = "#22262e", bold = true },
      GpsItemKindEnum = { fg = "#56b6c2", bg = "#22262e", bold = true },
      GpsItemKindUnit = { fg = "#c678dd", bg = "#22262e", bold = true },
      GpsItemKindClass = { fg = "#56b6c2", bg = "#22262e", bold = true },
      GpsItemKindFile = { fg = "#c8ccd4", bg = "#22262e", bold = true },
      GpsItemKindInterface = { fg = "#56b6c2", bg = "#22262e", bold = true },
      GpsItemKindColor = { fg = "#e06c75", bg = "#22262e", bold = true },
      GpsItemKindReference = { fg = "#abb2bf", bg = "#22262e", bold = true },
      GpsItemKindEnumMember = { fg = "#56b6c2", bg = "#22262e", bold = true },
      GpsItemKindStruct = { fg = "#c678dd", bg = "#22262e", bold = true },
      GpsItemKindValue = { fg = "#56b6c2", bg = "#22262e", bold = true },
      GpsItemKindEvent = { fg = "#56b6c2", bg = "#22262e", bold = true },
      GpsItemKindOperator = { fg = "#abb2bf", bg = "#22262e", bold = true },
      GpsItemKindTypeParameter = { fg = "#e06c75", bg = "#22262e", bold = true },
   },
}

return M
