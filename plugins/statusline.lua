local st_modules = require "nvchad_ui.statusline.modules"

-- mode component = mode component + " hi "
-- print 'hi' next to mode component
local LSP_status = function()
   local clients = vim.lsp.get_active_clients()
   local names = {}

   for _, client in ipairs(clients) do
      if client.attached_buffers[vim.api.nvim_get_current_buf()] then
         table.insert(names, client.name:sub(0, 2))
      end
   end

   local name = false

   if names ~= {} then
      name = table.concat(names, "|")
   end

   return (vim.o.columns > 70 and "%#St_LspStatus#" .. "   LSP ~ " .. name .. " ") or "   LSP "
end

local gps = function()
   if vim.o.columns < 140 or not package.loaded["nvim-gps"] then
      return ""
   end

   local gps = require "nvim-gps"
   return (gps.is_available() and gps.get_location()) or ""
end

return {
   LSP_status = LSP_status,

   LSP_progress = function()
      return st_modules.LSP_progress() .. gps()
   end,
}
