-- https://www.reddit.com/r/neovim/comments/1708ppd/comment/k3jo5oi/
local function lazy(keys)
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  return function()
    vim.o.lazyredraw = true
    vim.api.nvim_feedkeys(keys, 'nx', false)
    vim.o.lazyredraw = false
  end
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key"s default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

local opts = { noremap = true, silent = true }

-- Tab cycling helpers

local function tab_contains_nvimtree(tabpage)
  local wins = vim.api.nvim_tabpage_list_wins(tabpage)
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
    if ft == 'NvimTree' then
      return true
    end
  end
  return false
end
local function next_tab_cycle()
  local tabs = vim.api.nvim_list_tabpages()
  -- Filter out tabs that contain NvimTree
  local filtered_tabs = {}
  for _, tab in ipairs(tabs) do
    if not tab_contains_nvimtree(tab) then
      table.insert(filtered_tabs, tab)
    end
  end

  if #filtered_tabs == 0 then
    return  -- No tabs without NvimTree
  end

  local current = vim.api.nvim_get_current_tabpage()
  local current_index = 1
  for i, tab in ipairs(filtered_tabs) do
    if tab == current then
      current_index = i
      break
    end
  end
  local next_index = current_index % #filtered_tabs + 1
  vim.api.nvim_set_current_tabpage(filtered_tabs[next_index])
end

local function prev_tab_cycle()
  local tabs = vim.api.nvim_list_tabpages()
  -- Filter out tabs that contain NvimTree
  local filtered_tabs = {}
  for _, tab in ipairs(tabs) do
    if not tab_contains_nvimtree(tab) then
      table.insert(filtered_tabs, tab)
    end
  end

  if #filtered_tabs == 0 then
    return  -- No tabs without NvimTree
  end

  local current = vim.api.nvim_get_current_tabpage()
  local current_index = 1
  for i, tab in ipairs(filtered_tabs) do
    if tab == current then
      current_index = i
      break
    end
  end
  local prev_index = (current_index - 2) % #filtered_tabs + 1
  vim.api.nvim_set_current_tabpage(filtered_tabs[prev_index])
end

-- Telescope helpers for opening in new tab
local function telescope_find_files_in_new_tab()
  local actions = require('telescope.actions')
  require('telescope.builtin').find_files({
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = require('telescope.actions.state').get_selected_entry()
        if selection and selection.value then
          local escaped_path = vim.fn.fnameescape(selection.value)
          vim.cmd('tabnew ' .. escaped_path)
        end
      end)
      return true
    end
  })
end

local function telescope_live_grep_in_new_tab()
  local actions = require('telescope.actions')
  require('telescope.builtin').live_grep({
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = require('telescope.actions.state').get_selected_entry()
        if selection and selection.filename then
          local escaped_path = vim.fn.fnameescape(selection.filename)
          vim.cmd('tabnew')
          vim.cmd('e ' .. escaped_path)
          local lnum = selection.lnum or 1
          vim.cmd('normal! ' .. tostring(lnum) .. 'G')
          vim.cmd('normal! zz')  -- center the line
        end
      end)
      return true
    end
  })
end

--Normal mode
-- Vertical scroll and center
if vim.g.lazy_keys then
  vim.keymap.set('n', '<C-d>', lazy('<C-d>zz'), opts)
  vim.keymap.set('n', '<C-u>', lazy('<C-u>zz'), opts)
else
  vim.keymap.set('n', '<C-d>', '<cmd>normal! <C-d>zz<CR>', opts)
  vim.keymap.set('n', '<C-u>', '<cmd>normal! <C-u>zz<CR>', opts)
end
--vim.keymap.set('n', 'G', 'Gzz', opts)
vim.keymap.set('n', 'Z', '<Nop>', opts)
vim.keymap.set('n', 'ZZ', '<Nop>', opts)
vim.keymap.set('n', 'ZQ', '<Nop>', opts)
vim.keymap.set('n', 'J', 'mzJ`z', opts)
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true, desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true, desc = 'Previous search result (centered)' })

--Switch windows
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
-- vim.keymap.set('n', '<BS>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Window management
vim.keymap.set('n', '<leader>sv', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>sh', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xx', ':close<CR>', opts) -- close current split window

function _G.resize_up()
  local n = vim.v.count1
  vim.cmd('resize +' .. (2 * n))
end

function _G.resize_down()
  local n = vim.v.count1
  vim.cmd('resize -' .. (2 * n))
end

function _G.resize_left()
  local n = vim.v.count1
  vim.cmd('vertical resize -' .. (2 * n))
end

function _G.resize_right()
  local n = vim.v.count1
  vim.cmd('vertical resize +' .. (2 * n))
end

local function resize_op(fn)
  return function()
    vim.o.operatorfunc = fn
    return 'g@l'
  end
end

-- Resize windows
vim.keymap.set('n', '<leader>rh', resize_op('v:lua.resize_left'), { expr = true })
vim.keymap.set('n', '<leader>rj', resize_op('v:lua.resize_down'), { expr = true })
vim.keymap.set('n', '<leader>rk', resize_op('v:lua.resize_up'), { expr = true })
vim.keymap.set('n', '<leader>rl', resize_op('v:lua.resize_right'), { expr = true })

-- Buffers
vim.keymap.set('n', '<Tab>', function()
  local cur_ft = vim.bo.filetype
  if cur_ft == 'NvimTree' then
    vim.cmd('wincmd p')
  end
  vim.cmd('bnext')
end, { desc = 'Go to next buffer', noremap = true, silent = true })

vim.keymap.set('n', '<S-Tab>', function()
  local cur_ft = vim.bo.filetype
  if cur_ft == 'NvimTree' then
    vim.cmd('wincmd p')
  end
  vim.cmd('bprev')
end, { desc = 'Go to previous buffer', noremap = true, silent = true })
vim.keymap.set('n', '<leader>bd', ':bdelete!<CR>', opts) -- close buffer
-- vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

--Open terminal at the bottom (toggleterm) - Disabled, using Ctrl+` instead
-- vim.keymap.set('n', '<leader>ts', function()
--   local toggleterm = require('toggleterm.terminal')
--   local term = toggleterm.Terminal:new({ direction = 'horizontal' })
--   term:toggle()
-- end, { desc = 'Open terminal panel at bottom', noremap = true, silent = true })

--Run Python shell with one command (toggleterm) - Disabled, using Ctrl+` instead
-- vim.keymap.set('n', '<leader>tp', function()
--   local toggleterm = require('toggleterm.terminal')
--   local term = toggleterm.Terminal:new({
--     cmd = 'python3',
--     direction = 'horizontal',
--     on_open = function(term)
--       -- 自动激活虚拟环境
--       local root_dir = vim.fn.getcwd()
--       local venv_path
--       if vim.fn.isdirectory(root_dir .. '/.venv') == 1 then
--         venv_path = root_dir .. '/.venv'
--       elseif vim.fn.isdirectory(root_dir .. '/venv') == 1 then
--         venv_path = root_dir .. '/venv'
--       end
--
--       if venv_path then
--         local activate = venv_path .. '/bin/activate'
--         if vim.fn.filereadable(activate) == 1 then
--           vim.fn.chansend(term.job_id, 'source ' .. activate .. '\n')
--         end
--       end
--     end,
--   })
--   term:toggle()
-- end, { desc = 'Open Python terminal panel', noremap = true, silent = true })

--Open floating terminal window (toggleterm) - Disabled, using Ctrl+` instead
-- vim.keymap.set('n', '<leader>tn', function()
--   local toggleterm = require('toggleterm.terminal')
--   local term = toggleterm.Terminal:new({ direction = 'float' })
--   term:toggle()
-- end, { desc = 'Open floating terminal', noremap = true, silent = true })

--Toggle terminal panel (same as Ctrl+`) - Disabled, using Ctrl+` instead
-- vim.keymap.set('n', '<leader>tt', function()
--   local toggleterm = require('toggleterm.terminal')
--   local term = toggleterm.Terminal:new({ direction = 'horizontal' })
--   term:toggle()
-- end, { desc = 'Toggle terminal panel', noremap = true, silent = true })

--Save current file
vim.keymap.set('n', '<leader>ww', '<cmd>w<CR>', opts)

-- Save file without auto-formatting
vim.keymap.set('n', '<leader>wd', '<cmd>noautocmd w <CR>', opts)

--Close current file
vim.keymap.set('n', '<leader>wc', '<cmd>q<CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- clear highlighting
vim.keymap.set('n', '<A-m>', '<cmd>noh<CR>', opts)

-- nvim tree toggle
vim.keymap.set('n', '<leader>E', '<cmd>NvimTreeToggle<CR>', opts)

-- substitute a word with last yanked
vim.keymap.set('n', 'S', 'diw"0P', opts)

-- Insert mode
-- Move cursor
vim.keymap.set('i', '<A-h>', '<Left>', opts)
vim.keymap.set('i', '<A-j>', '<Down>', opts)
vim.keymap.set('i', '<A-k>', '<Up>', opts)
vim.keymap.set('i', '<A-l>', '<Right>', opts)

-- Paste
vim.keymap.set('i', '<A-p>', '<Esc>"+pa', opts)

--Visual mode
--Move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', { noremap = true, silent = true, desc = 'Paste without overwriting register' })

-- Terminal mode
--vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<CR>") -- rather keep terminal shortcuts for deletion
vim.keymap.set('t', '<C-j>', '<cmd>wincmd j<CR>', opts)
vim.keymap.set('t', '<C-k>', '<cmd>wincmd k<CR>', opts)
--vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<CR>") -- rather keep terminal shortcuts for clearing

--close terminal
vim.keymap.set('t', '<A-Esc>', '<C-\\><C-n>')

-- Diagnostics toggle
-- https://www.reddit.com/r/neovim/comments/1ae6iwm/disable_lsp_diagnostics/
vim.g['diagnostics_active'] = true
function Toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.enable(false)
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.enable()
  end
end

vim.keymap.set('n', '<leader>dd', Toggle_diagnostics, opts)

-- open diagnostics in a float window
vim.keymap.set('n', '<leader>df', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

-- Diff current file with staged version in Meld (async)
vim.keymap.set('n', '<leader>gm', function()
  if vim.bo.buftype ~= '' then
    return
  end
  vim.cmd('noautocmd write')
  vim.fn.jobstart({ 'git', 'difftool', vim.fn.expand('%') }, {
    on_exit = function()
      vim.schedule(function()
        vim.cmd('checktime')
      end)
    end,
  })
end, opts)

-- Launch Meld as mergetool (async)
vim.keymap.set('n', '<leader>gM', function()
  if vim.bo.buftype ~= '' then
    return
  end
  vim.cmd('noautocmd write')
  vim.fn.jobstart({ 'git', 'mergetool', vim.fn.expand('%') }, {
    on_exit = function()
      vim.schedule(function()
        vim.cmd('checktime')
      end)
    end,
  })
end, opts)

-- ===========================================
-- VS Code Style Keymaps from README_TARGET.md
-- ===========================================

-- File management
-- Ctrl+B: Toggle file explorer (nvim-tree)
vim.keymap.set('n', '<C-b>', '<cmd>NvimTreeToggle<CR>', opts)
-- Ctrl+P: Quick open file (telescope find_files)
vim.keymap.set('n', '<C-p>', telescope_find_files_in_new_tab, opts)
-- Ctrl+S: Save file
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', opts)
vim.keymap.set('i', '<C-s>', '<Esc><cmd>w<CR>a', opts)
-- Ctrl+W: Close current file (window)
vim.keymap.set('n', '<C-w>', '<C-w>c', opts)
-- Ctrl+F: Open Search-Replace in current file
vim.keymap.set('n', '<C-f>', function()
  local word = vim.fn.expand('<cword>')
  local search_replace = require('search-replace')
  if word and word ~= '' then
    -- Open with current word as search text
    search_replace.open({ visual_text = word })
  else
    search_replace.open()
  end
end, opts)
vim.keymap.set('v', '<C-f>', function()
  require('search-replace').open()
end, opts)
vim.keymap.set('i', '<C-f>', '<Esc><C-f>', opts)
-- Ctrl+Shift+F: Open Search-Replace in all files
vim.keymap.set('n', '<C-S-f>', function()
  local word = vim.fn.expand('<cword>')
  local search_replace = require('search-replace')
  if word and word ~= '' then
    -- Open with current word as search text
    search_replace.open({ visual_text = word })
  else
    search_replace.open()
  end
end, opts)
vim.keymap.set('v', '<C-S-f>', function()
  require('search-replace').open_visual()
end, opts)
vim.keymap.set('i', '<C-S-f>', '<Esc><C-S-f>', opts)
-- Ctrl+Shift+P: Search for files containing text (telescope live_grep)
vim.keymap.set('n', '<C-S-p>', telescope_live_grep_in_new_tab, opts)
vim.keymap.set('i', '<C-S-p>', '<Esc><C-S-p>', opts)
-- Ctrl+Q: Search for text in current file (telescope current_buffer_fuzzy_find)
vim.keymap.set('n', '<C-q>', function() require('telescope.builtin').current_buffer_fuzzy_find() end, opts)
vim.keymap.set('i', '<C-q>', '<Esc><C-q>', opts)
-- Space+E: Focus file explorer (leader is space)
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', opts)

-- Buffer management
-- Ctrl+PageUp: Previous file (buffer)
vim.keymap.set('n', '<C-PageUp>', '<cmd>bprevious<CR>', opts)
vim.keymap.set('n', '<C-PageDown>', '<cmd>bnext<CR>', opts)
-- Space+fb already mapped to telescope buffers

-- Basic editing (copy, cut, paste, select all)
-- Note: These work in visual mode only when text is selected
vim.keymap.set('v', '<C-c>', '"+y', opts) -- copy
vim.keymap.set('v', '<C-x>', '"+d', opts) -- cut
vim.keymap.set('v', '<C-v>', '"+P', opts) -- paste (overwrites selection)
vim.keymap.set('n', '<C-v>', '"+P', opts) -- paste in normal mode
vim.keymap.set('n', '<C-a>', 'ggVG', opts) -- select all
vim.keymap.set('i', '<C-v>', '<Esc>"+Pa', opts) -- paste in insert mode

-- Undo/Redo
vim.keymap.set('n', '<C-z>', 'u', opts) -- undo
vim.keymap.set('n', '<C-y>', '<C-r>', opts) -- redo
vim.keymap.set('i', '<C-z>', '<Esc>ua', opts) -- undo in insert
vim.keymap.set('i', '<C-y>', '<Esc><C-r>a', opts) -- redo in insert

-- Quick edits
-- Ctrl+D: Duplicate line
vim.keymap.set('n', '<C-d>', 'yyp', opts)
vim.keymap.set('i', '<C-d>', '<Esc>yypa', opts)
-- Ctrl+/: Toggle comment (using Comment.nvim)
vim.keymap.set('n', '<C-/>', function() require('Comment.api').toggle.linewise.current() end, opts)
vim.keymap.set('v', '<C-/>', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', opts)
-- Ctrl+Shift+K: Delete line
vim.keymap.set('n', '<C-S-k>', 'dd', opts)
vim.keymap.set('i', '<C-S-k>', '<Esc>ddi', opts)
-- Alt+Shift+J/K: Move line down/up
vim.keymap.set('n', '<A-S-j>', ':m .+1<CR>==', opts)
vim.keymap.set('n', '<A-S-k>', ':m .-2<CR>==', opts)
vim.keymap.set('i', '<A-S-j>', '<Esc>:m .+1<CR>==gi', opts)
vim.keymap.set('i', '<A-S-k>', '<Esc>:m .-2<CR>==gi', opts)
vim.keymap.set('v', '<A-S-j>', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', '<A-S-k>', ":m '<-2<CR>gv=gv", opts)

-- Navigation between windows (splits)
vim.keymap.set('n', '<A-h>', '<C-w>h', opts)
vim.keymap.set('n', '<A-j>', '<C-w>j', opts)
vim.keymap.set('n', '<A-k>', '<C-w>k', opts)
vim.keymap.set('n', '<A-l>', '<C-w>l', opts)
-- Alternative with arrow keys
vim.keymap.set('n', '<A-Left>', '<C-w>h', opts)
vim.keymap.set('n', '<A-Down>', '<C-w>j', opts)
vim.keymap.set('n', '<A-Up>', '<C-w>k', opts)
vim.keymap.set('n', '<A-Right>', '<C-w>l', opts)

-- Resizing windows
vim.keymap.set('n', '<S-Up>', '<cmd>resize +2<CR>', opts)
vim.keymap.set('n', '<S-Down>', '<cmd>resize -2<CR>', opts)
vim.keymap.set('n', '<S-Left>', '<cmd>vertical resize -2<CR>', opts)
vim.keymap.set('n', '<S-Right>', '<cmd>vertical resize +2<CR>', opts)
-- Alternative: Space + arrow (leader is space)
vim.keymap.set('n', '<leader><Up>', '<cmd>resize +2<CR>', opts)
vim.keymap.set('n', '<leader><Down>', '<cmd>resize -2<CR>', opts)
vim.keymap.set('n', '<leader><Left>', '<cmd>vertical resize -2<CR>', opts)
vim.keymap.set('n', '<leader><Right>', '<cmd>vertical resize +2<CR>', opts)

-- Split management
-- Ctrl+\ : Vertical split
vim.keymap.set('n', '<C-\\>', '<C-w>v', opts)
-- Ctrl+Alt+\ : Horizontal split
vim.keymap.set('n', '<C-A-\\>', '<C-w>s', opts)
-- Ctrl+W : Close split window (same as above)

-- Terminal
-- Ctrl+` : Toggle terminal panel (VSCode style) using toggleterm.nvim
vim.keymap.set('n', '<C-`>', function()
  local toggleterm = require('toggleterm.terminal')
  local term = toggleterm.Terminal:new({ direction = 'horizontal' })
  term:toggle()
end, { desc = 'Toggle terminal panel (VSCode style)', noremap = true, silent = true })
-- Esc to exit terminal mode (already default)

-- Code intelligence (LSP) - mostly already exists
-- gd, gr, K, F2, Space+ca
-- LSP mappings are set in lsp.lua, but add Space+ca for code actions
vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.keymap.set('v', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

-- Search shortcuts (some already exist)
-- Ctrl+P already mapped to find_files
-- Ctrl+Shift+F already mapped to live_grep
-- Space+ff already mapped to find_files
-- Space+fg already mapped to live_grep
-- Space+fh: Help tags
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, opts)

-- Theme management (Space+T)
vim.keymap.set('n', '<leader>tt', '<cmd>lua require("config.colorscheme").toggle()<CR>', opts) -- toggle theme
vim.keymap.set('n', '<leader>th', '<cmd>lua require("config.colorscheme").next_bearded_flavor()<CR>', opts) -- toggle bearded flavor

-- Tab management (if needed)
-- Ctrl+T: New tab
vim.keymap.set('n', '<C-t>', '<cmd>tabnew<CR>', opts)
-- Ctrl+Tab: Next tab
vim.keymap.set('n', '<C-Tab>', next_tab_cycle, opts)
-- Ctrl+Shift+Tab: Previous tab
vim.keymap.set('n', '<C-S-Tab>', prev_tab_cycle, opts)
