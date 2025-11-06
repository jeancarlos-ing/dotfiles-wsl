-- MIT License

-- Copyright (c) 2025 Jean Carlos
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

-------------------------
-- EDITOR SETTINGS
-------------------------

vim.o.number = true         -- Show line numbers
vim.o.ignorecase = true     -- Case-insensitive search
vim.o.smartcase = true      -- Uppercase overrides ignorecase
vim.o.hlsearch = false      -- Disable search highlight
vim.o.wrap = true           -- Wrap long lines
vim.o.breakindent = true    -- Indent wrapped lines
vim.o.tabstop = 2           -- Tab width
vim.o.shiftwidth = 2        -- Indent width
vim.o.expandtab = false     -- Use tabs
vim.o.termguicolors = true  -- Enable true colors

-------------------------
-- KEYMAPS
-------------------------

vim.g.mapleader = ' '

-- Navigation
vim.keymap.set({'n','x','o'}, '<leader>h','^')
vim.keymap.set({'n','x','o'}, '<leader>l','g_')
vim.keymap.set('n','<leader>a',':keepjumps normal! ggVG<cr>')

-- Clipboard
vim.keymap.set({'n','x'}, 'gy','"+y')
vim.keymap.set({'n','x'}, 'gp','"+p')

-- Delete without affecting register
vim.keymap.set({'n','x'}, 'x','"_x')
vim.keymap.set({'n','x'}, 'X','"_d')

-- Files & buffers
vim.keymap.set('n','<leader>w','<cmd>write<cr>')
vim.keymap.set('n','<leader>bq','<cmd>bdelete<cr>')
vim.keymap.set('n','<leader>bl','<cmd>buffer #<cr>')

-- TODO.txt
vim.keymap.set("n","<leader>tn","<cmd>TodoTxt new<cr>")
vim.keymap.set("n","<leader>tt","<cmd>TodoTxt<cr>")
vim.keymap.set("n","<leader>td","<cmd>DoneTxt<cr>")
vim.keymap.set("n","<leader>tg","<cmd>TodoTxt ghost<cr>")
vim.keymap.set("n","<cr>","<Plug>(TodoTxtToggleState)")
vim.keymap.set("n","<c-c>n","<Plug>(TodoTxtCyclePriority)")
vim.keymap.set("n","<leader>tm","<Plug>(TodoTxtMoveDone)")
vim.keymap.set("n","<leader>tss","<Plug>(TodoTxtSortTasks)")
vim.keymap.set("n","<leader>tsp","<Plug>(TodoTxtSortByPriority)")
vim.keymap.set("n","<leader>tsc","<Plug>(TodoTxtSortByContext)")
vim.keymap.set("n","<leader>tsP","<Plug>(TodoTxtSortByProject)")
vim.keymap.set("n","<leader>tsd","<Plug>(TodoTxtSortByDueDate)")

-------------------------
-- COMMANDS & AUTOCMDS
-------------------------

vim.api.nvim_create_user_command('ReloadConfig','source $MYVIMRC',{})  -- Reload config

local group = vim.api.nvim_create_augroup('user_cmds',{clear=true})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost',{
  group=group,
  callback=function() vim.highlight.on_yank({higroup='Visual',timeout=200}) end,
})

-- Quick quit for help/man
vim.api.nvim_create_autocmd('FileType',{
  pattern={'help','man'},
  group=group,
  command='nnoremap <buffer> q <cmd>quit<cr>'
})

-------------------------
-- MINI.DEPS BOOTSTRAP
-------------------------

local MiniDeps=(function()
  local packpath=vim.fn.stdpath('data')..'/site'
  local mini_path=packpath..'/pack/deps/start/mini.nvim'
  if not vim.loop.fs_stat(mini_path) then
    print('Installing mini.nvim...')
    vim.fn.system({'git','clone','--filter=blob:none','https://github.com/nvim-mini/mini.nvim','--branch=main',mini_path})
    vim.cmd('packadd mini.nvim | helptags ALL')
  end
  local ok,deps=pcall(require,'mini.deps')
  if not ok then return {} end
  return deps
end)()

if MiniDeps.setup then MiniDeps.setup({path={package=vim.fn.stdpath('data')..'/site'}}) end

-------------------------
-- PLUGINS
-------------------------

MiniDeps.add({source='nvim-mini/mini.nvim',checkout='main'})
MiniDeps.add({source='ellisonleao/gruvbox.nvim'})
MiniDeps.add({source='phrmendes/todotxt.nvim'})
MiniDeps.add({source='neovim/nvim-lspconfig',depends={'williamboman/mason.nvim'}})
MiniDeps.add({source='williamboman/mason.nvim'})
MiniDeps.add({source='williamboman/mason-lspconfig.nvim'})
MiniDeps.add({source='nvim-treesitter/nvim-treesitter',checkout='master',hooks={post_checkout=function() vim.cmd('TSUpdate') end}})

-------------------------
-- MINI.NVIM CONFIG
-------------------------

MiniDeps.now(function()
  -- Core plugins
  local mini={ 'align','comment','completion','keymap','move','pairs','operators','snippets','splitjoin','surround','basics','bracketed','bufremove','clue','diff','extra','files','git','jump','jump2d','misc','pick','sessions','visits','animate','colors','cursorword','hipatterns','indentscope','notify','tabline','trailspace','doc','fuzzy','test'}

  for _,p in ipairs(mini) do require('mini.'..p).setup() end
  -- TODO.txt

  require('todotxt').setup({
    todotxt=vim.env.HOME..'/notes/todo.txt',
    donetxt=vim.env.HOME..'/notes/done.txt',
    ghost_text={enable=true},
    prefix=' ',
    highlight='Comment',
  })
end)

vim.filetype.add({filename={['todo.txt']='todotxt',['done.txt']='todotxt'}})

-------------------------
-- THEME
-------------------------

vim.o.background='dark'

vim.cmd([[colorscheme gruvbox]])
require('gruvbox').setup({
  terminal_colors=true,
  undercurl=true,
  underline=true,
  bold=true,
  italic={strings=true,emphasis=true,comments=true,operators=false,folds=true},
  strikethrough=true,
  invert_selection=false,
  invert_signs=false,
  invert_tabline=false,
  inverse=true,
  contrast='hard',
  transparent_mode=true
})

-------------------------
-- TREESITTER
-------------------------

require'nvim-treesitter.configs'.setup{
  ensure_installed={'javascript','typescript','json','html','css','c','lua','vim','vimdoc','query','markdown','markdown_inline','todotxt'},
  sync_install=false,
  auto_install=true,
  highlight={
    enable=true,
    disable=function(_,buf)
      local ok,stats=pcall(vim.loop.fs_stat,vim.api.nvim_buf_get_name(buf))
      return ok and stats and stats.size>100*1024
    end,
    additional_vim_regex_highlighting=false,
  },
}

-------------------------
-- MASON + LSP
-------------------------
---
require('mason').setup()                          -- Mason installer
require('mason-lspconfig').setup({ensure_installed={'tsserver'}}) -- Ensure TS/JS LSP
require('lspconfig').tsserver.setup({})           -- LSP setup


