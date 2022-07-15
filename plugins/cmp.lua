local present, cmp = pcall(require, "cmp")

if not present then
   return
end

require("base46").load_highlight "cmp"

vim.opt.completeopt = "menu,menuone,noselect"

local has_words_before = function()
   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local function border(hl_name)
   return {
      { "╭", hl_name },
      { "─", hl_name },
      { "╮", hl_name },
      { "│", hl_name },
      { "╯", hl_name },
      { "─", hl_name },
      { "╰", hl_name },
      { "│", hl_name },
   }
end

local cmp_window = require "cmp.utils.window"

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
   local info = self:info_()
   info.scrollable = false
   return info
end

local options = {
   window = {
      completion = {
         border = border "CmpBorder",
         winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
         border = border "CmpDocBorder",
      },
   },
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end,
   },
   formatting = {
      format = function(entry, vim_item)
         local icons = require("nvchad_ui.icons").lspkind
         vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

         vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            cmp_tabnine = "[TN]",
            copilot = "[CP]",
            buffer = "[BUF]",
         })[entry.source.name]

         return vim_item
      end,
   },
   sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "cmp_tabnine" },
      { name = "copilot", priority = 99999 },
   },
   mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Insert,
         select = true,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif has_words_before() then
            cmp.select_prev_item()
         elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
         else
            fallback()
         end
      end, {
         "i",
         "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif has_words_before() then
            cmp.select_prev_item()
         elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
         else
            fallback()
         end
      end, {
         "i",
         "s",
      }),
   },
}

-- check for any override
options = require("core.utils").load_override(options, "hrsh7th/nvim-cmp")

cmp.setup(options)
