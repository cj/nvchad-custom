local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {
   -- webdev stuff
   -- b.formatting.deno_fmt,

   b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "graphql", "caddyfile", "json" } },

   -- Lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

   -- cpp
   b.formatting.clang_format,

   b.diagnostics.eslint_d, -- eslint or eslint_d
   b.formatting.eslint_d, -- eslint or eslint_d
   b.code_actions.eslint_d, -- eslint or eslint_d
}

local M = {}

M.setup = function()
   local f = io.open("./deno.json", "r")

   if f ~= nil then
      io.close(f)
      null_ls.setup {
         debug = false,
         sources = {
            b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "graphql", "caddyfile", "json" } },

            -- Lua
            b.formatting.stylua,
            b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

            -- Shell
            b.formatting.shfmt,
            b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

            -- cpp
            b.formatting.clang_format,
         },
      }
   else
      null_ls.setup {
         debug = false,
         sources = sources,
         on_attach = function(client, bufnr)
            require("navigator.lspclient.attach").on_attach(client, bufnr)
         end,
      }
   end
end

return M
