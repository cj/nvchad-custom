-- example file i.e lua/custom/init.lua

-- MAPPINGS
-- require "custom.mappings"

-- require("my autocmds file") or just declare them here

-- vim.g.nvim_tree_special_files = {}
-- vim.g.nvim_tree_add_trailing = 1
-- vim.g.nvim_tree_show_icons = {
--    git = 1,
--    folders = 1,
--    files = 1,
--    folder_arrows = 0,
-- }
-- vim.g.nvim_tree_icons = {
--    default = "",
--    symlink = "",
--    folder = {
--       arrow_open = "",
--       arrow_closed = "",
--       default = "",
--       open = "",
--       empty = "",
--       empty_open = "",
--       symlink = "",
--       symlink_open = "",
--    },
-- }
local set = vim.opt -- set options
set.fillchars = set.fillchars + "diff:╱"

vim.o.completeopt = "menu,menuone,noselect"

vim.g.mapleader = ";"

vim.lsp.set_log_level('error')

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
    vim.lsp.buf.formatting_seq_sync(nil, 10000)
  end,
})

vim.cmd [[
      set cmdheight=2
      set shortmess=AsIF

      " imap <silent><script><expr> <C-e> copilot#Accept("\<CR>")
      let g:copilot_no_tab_map = v:true
      let g:copilot_assume_mapped = v:true
      let g:copilot_filetypes = {
                      \ 'guihua': v:false,
                      \ 'telescope': v:false,
                      \ }
      set pumblend=20

      let g:Illuminate_ftblacklist = ['NvimTree']


      let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
      if executable(s:clip)
          augroup WSLYank
              autocmd!
              autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
          augroup END
      endif
      if has('wsl')
    let g:clipboard = {
          \   'name': 'wslclipboard',
          \   'copy': {
          \      '+': '/mnt/c/Windows/System32/win32yank.exe -i --crlf',
          \      '*': '/mnt/c/Windows/System32/win32yank.exe -i --crlf',
          \    },
          \   'paste': {
          \      '+': '/mnt/c/Windows/System32/win32yank.exe -o --lf',
          \      '*': '/mnt/c/Windows/System32/win32yank.exe -o --lf',
          \   },
          \   'cache_enabled': 1,
          \ }
endif

noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

    hi IndentBlanklineContextChar cterm=none gui=none guifg=#e5c07b

    augroup illuminate_augroup
      autocmd!
      autocmd BufReadPost * hi illuminatedword cterm=underline gui=underline
      autocmd BufReadPost * hi Folded guibg=#292f3b
      autocmd VimEnter set fillchars+=diff:╱
      autocmd BufReadPost * hi matchword cterm=underline gui=none guifg=none guibg=none
      autocmd BufReadPost * hi LspReferenceRead cterm=none gui=none guifg=none guibg=none
      autocmd BufReadPost * hi LspReferenceText cterm=none gui=none guifg=none guibg=none
      autocmd BufReadPost * hi LspReferenceWrite cterm=none gui=none guifg=none guibg=none
      autocmd BufReadPost * silent! nunmap <leader>fÞ
      autocmd BufReadPost * silent! nunmap <leader>rÞ
      autocmd BufReadPost * silent! nunmap <leader>tÞ
      autocmd BufReadPost * silent! nunmap <leader>rÞ

    augroup end

    map <silent> <enter> :noh<cr>

    " Zoom
    function! s:zoom()
      if winnr('$') > 1
        tab split
      elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
            \ 'index(v:val, '.bufnr('').') >= 0')) > 1
        tabclose
      endif
    endfunction

    nnoremap <silent> <leader>z :call <sid>zoom()<cr>

    omap t <plug>(easymotion-bd-tl)
    vmap t <plug>(easymotion-bd-tl)
    map f <plug>(easymotion-fl)
    map f <plug>(easymotion-fl)

    autocmd User EasyMotionPromptBegin silent! LspStop
    autocmd User EasyMotionPromptEnd silent! LspStart

    " Show syntax highlighting groups for word under cursor
    nmap <F2> :call <SID>SynStack()<CR>
    function! <SID>SynStack()
        if !exists("*synstack")
            return
        endif
        echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endfunc
    ]]
