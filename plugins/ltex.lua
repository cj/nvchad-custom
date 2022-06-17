-- https://gist.github.com/lbiaggi/a3eb761ac2fdbff774b29c88844355b8
--- BEFORE USING, change language entries to fit your needs.

local M = {}

M.Dictionary_file = {
   ["en-US"] = { vim.fn.stdpath "config" .. "/lua/custom/spell/dictionary.txt" }, -- there is another way to find ~/.config/nvim ?
}

M.DisabledRules_file = {
   ["en-US"] = { vim.fn.stdpath "config" .. "/lua/custom/spell/disable.txt" }, -- there is another way to find ~/.config/nvim ?
}

M.FalsePositives_file = {
   ["en-US"] = { vim.fn.stdpath "config" .. "/lua/custom/spell/false.txt" }, -- there is another way to find ~/.config/nvim ?
}

M.readFiles = function(files)
   local dict = {}
   for _, file in ipairs(files) do
      local f = io.open(file, "r")
      for l in f:lines() do
         table.insert(dict, l)
      end
   end
   return dict
end

M.findLtexLang = function()
   local buf_clients = vim.lsp.buf_get_clients()
   for _, client in ipairs(buf_clients) do
      if client.name == "ltex" then
         return client.config.settings.ltex.language
      end
   end
end

M.findLtexFiles = function(filetype, value)
   local files = nil
   if filetype == "dictionary" then
      files = M.Dictionary_file[value or M.findLtexLang()]
   elseif filetype == "disable" then
      files = M.DisabledRules_file[value or M.findLtexLang()]
   elseif filetype == "falsePositive" then
      files = M.FalsePositives_file[value or M.findLtexLang()]
   end

   if files then
      return files
   else
      return nil
   end
end

M.updateConfig = function(lang, configtype)
   local buf_clients = vim.lsp.get_active_clients()
   local client = nil
   for _, lsp in ipairs(buf_clients) do
      print(lsp.name)
      if lsp.name == "ltex" then
         client = lsp
      end
   end

   print(client, lang, configtype)

   if client then
      if configtype == "dictionary" then
         if client.config.settings.ltex.dictionary then
            client.config.settings.ltex.dictionary = {
               [lang] = M.readFiles(M.Dictionary_file[lang]),
            }
            -- return client.notify("workspace/didChangeConfiguration", client.config.settings)
         else
            return vim.notify "Error when reading dictionary config, check it"
         end
      elseif configtype == "disable" then
         if client.config.settings.ltex.disabledRules then
            client.config.settings.ltex.disabledRules = {
               [lang] = M.readFiles(M.DisabledRules_file[lang]),
            }
            -- return client.notify("workspace/didChangeConfiguration", client.config.settings)
         else
            return vim.notify "Error when reading disabledRules config, check it"
         end
      elseif configtype == "falsePositive" then
         if client.config.settings.ltex.hiddenFalsePositives then
            client.config.settings.ltex.hiddenFalsePositives = {
               [lang] = M.readFiles(M.FalsePositives_file[lang]),
            }
            -- return client.notify("workspace/didChangeConfiguration", client.config.settings)
         else
            return vim.notify "Error when reading hiddenFalsePositives config, check it"
         end
      end
   else
      return nil
   end
end

M.addToFile = function(filetype, lang, file, value)
   file = io.open(file[#file - 0], "a+") -- add only to last file defined.
   if file then
      file:write(value .. "\n")
      file:close()
   else
      return print("Failed insert %q", value)
   end
   if filetype == "dictionary" then
      return M.updateConfig(lang, "dictionary")
   elseif filetype == "disable" then
      return M.updateConfig(lang, "disable")
   elseif filetype == "falsePositive" then
      return M.updateConfig(lang, "disable")
   end
end

M.addTo = function(filetype, lang, file, value)
   local dict = M.readFiles(file)
   for _, v in ipairs(dict) do
      if v == value then
         return nil
      end
   end

   return M.addToFile(filetype, lang, file, value)
end

-- if not lspconfig.ltex then
--    configs.ltex = {
--       default_config = {
--          cmd = { "ltex-ls" },
--          filetypes = { "tex", "bib", "md" },
--          root_dir = function(filename)
--             return util.path.dirname(filename)
--          end,
--          settings = {
--             ltex = {
--                enabled = { "latex", "tex", "bib", "md" },
--                checkFrequency = "save",
--                language = "en-US",
--                diagnosticSeverity = "information",
--                setenceCacheSize = 5000,
--                additionalRules = {
--                   enablePickyRules = true,
--                   motherTongue = "en-US",
--                },
--                -- trace = { server = "verbose"};
--                -- ['ltex-ls'] = {
--                --     logLevel = "finest",
--                -- },
--                dictionary = {
--                   ["en-US"] = readFiles(Dictionary_file["en-US"] or {}),
--                },
--                disabledRules = {
--                   ["en-US"] = readFiles(DisabledRules_file["en-US"] or {}),
--                },
--                hiddenFalsePositives = {
--                   ["en-US"] = readFiles(FalsePositives_file["en-US"] or {}),
--                },
--             },
--          },
--       },
--    }
-- end

-- lspconfig.ltex.setup {}
-- lspconfig.ltex.dictionary_file = Dictionary_file
-- lspconfig.ltex.disabledrules_file = DisabledRules_file
-- lspconfig.ltex.falsepostivies_file = FalsePositives_file

-- https://github.com/neovim/nvim-lspconfig/issues/858 can't intercept,
-- override it then.
M.override_execute_command = function()
   local orig_execute_command = vim.lsp.buf.execute_command
   vim.lsp.buf.execute_command = function(command)
      if command.command == "_ltex.addToDictionary" then
         local arg = command.arguments[1].words -- can I really access like this?
         for lang, words in pairs(arg) do
            for _, word in ipairs(words) do
               local filetype = "dictionary"
               M.addTo(filetype, lang, M.findLtexFiles(filetype, lang), word)
            end
         end
      elseif command.command == "_ltex.disableRules" then
         local arg = command.arguments[1].ruleIds -- can I really access like this?
         for lang, rules in pairs(arg) do
            for _, rule in ipairs(rules) do
               local filetype = "disable"
               M.addTo(filetype, lang, M.findLtexFiles(filetype, lang), rule)
            end
         end
      elseif command.command == "_ltex.hideFalsePositives" then
         local arg = command.arguments[1].falsePositives -- can I really access like this?
         for lang, rules in pairs(arg) do
            for _, rule in ipairs(rules) do
               local filetype = "falsePositive"
               M.addTo(filetype, lang, M.findLtexFiles(filetype, lang), rule)
            end
         end
      else
         orig_execute_command(command)
      end
   end
end

return M
