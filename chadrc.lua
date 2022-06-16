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

return M
