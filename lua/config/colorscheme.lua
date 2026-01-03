local M = {}

local themes = { 'arctic', 'gruvbox', 'bearded' }
local current_index = 1

-- Bearded theme flavors (subset of available flavors)
local bearded_flavors = {
  -- Original favorites
  'arc',
  'arc-blueberry',
  'oceanic',
  'monokai-terra',
  'solarized-dark',
  'hc-flurry',
  'milkshake-raspberry',
  -- Black series
  'black-&-amethyst',
  'black-&-amethyst-soft',
  'black-&-diamond',
  'black-&-diamond-soft',
  'black-&-emerald',
  'black-&-emerald-soft',
  'black-&-gold',
  'black-&-gold-soft',
  'black-&-ruby',
  'black-&-ruby-soft',
  -- Monokai series
  'monokai-black',
  'monokai-metallian',
  'monokai-stone',
  -- Solarized series
  'solarized-light',
  'solarized-reversed',
  -- Oceanic series
  'oceanic-reversed',
  -- Stained series
  'stained-purple',
  'stained-blue',
  -- Vivid series
  'vivid-black',
  'vivid-light',
  'vivid-purple',
  -- Other popular
  'earth',
  'coffee',
  'coffee-reversed',
  'themanopia',
  'void',
}
local current_bearded_flavor_index = 1

-- State file for persistence
local state_dir = vim.fn.stdpath('state')
local state_file = state_dir .. '/colorscheme-state.json'

-- Load state from file
local function load_state()
  local ok, data = pcall(vim.fn.readfile, state_file)
  if not ok or #data == 0 then
    return nil
  end
  local json_str = table.concat(data, '\n')
  local ok2, state = pcall(vim.json.decode, json_str)
  if not ok2 or not state then
    return nil
  end
  return state
end

-- Save state to file
local function save_state()
  local state = {
    current_index = current_index,
    current_bearded_flavor_index = current_bearded_flavor_index,
  }
  local json_str = vim.json.encode(state)
  -- Ensure state directory exists
  vim.fn.mkdir(state_dir, 'p')
  vim.fn.writefile({json_str}, state_file)
end

-- Helper function to apply theme with proper flavor handling
local function apply_theme(theme_name)
  if theme_name == 'bearded' then
    local flavor = bearded_flavors[current_bearded_flavor_index]
    -- Use bearded plugin's load function to apply the flavor
    local ok, bearded = pcall(require, 'bearded')
    if ok then
      bearded.load(flavor)
    else
      -- Fallback to colorscheme command if plugin not available
      vim.cmd('colorscheme bearded')
    end
  else
    vim.cmd('colorscheme ' .. theme_name)
  end
end

function M.setup()
  -- Load saved state
  local state = load_state()
  if state then
    current_index = state.current_index or current_index
    current_bearded_flavor_index = state.current_bearded_flavor_index or current_bearded_flavor_index
  end

  -- Ensure indices are within valid ranges
  if current_index < 1 or current_index > #themes then
    current_index = 1
  end
  if current_bearded_flavor_index < 1 or current_bearded_flavor_index > #bearded_flavors then
    current_bearded_flavor_index = 1
  end

  -- Ensure themes are available
  -- This function can be called to initialize default theme
  apply_theme(themes[current_index])
end

function M.toggle()
  current_index = current_index % #themes + 1
  apply_theme(themes[current_index])
  save_state()
  vim.notify('Switched to ' .. themes[current_index], vim.log.levels.INFO)
end

function M.next()
  current_index = current_index % #themes + 1
  apply_theme(themes[current_index])
  save_state()
  vim.notify('Switched to ' .. themes[current_index], vim.log.levels.INFO)
end

function M.prev()
  current_index = (current_index - 2) % #themes + 1
  apply_theme(themes[current_index])
  save_state()
  vim.notify('Switched to ' .. themes[current_index], vim.log.levels.INFO)
end

-- Helper function to check if table contains value
local function table_contains(tbl, value)
  for _, v in ipairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

-- Set specific bearded flavor
function M.set_bearded_flavor(flavor)
  if not table_contains(bearded_flavors, flavor) then
    vim.notify('Invalid bearded flavor: ' .. flavor, vim.log.levels.ERROR)
    return
  end
  -- Update current flavor index
  for i, f in ipairs(bearded_flavors) do
    if f == flavor then
      current_bearded_flavor_index = i
      break
    end
  end
  -- Apply the flavor if current theme is bearded
  if themes[current_index] == 'bearded' then
    apply_theme('bearded')
    vim.notify('Bearded flavor set to ' .. flavor, vim.log.levels.INFO)
  end
  save_state()
end

-- Switch to next bearded flavor
function M.next_bearded_flavor()
  current_bearded_flavor_index = current_bearded_flavor_index % #bearded_flavors + 1
  local flavor = bearded_flavors[current_bearded_flavor_index]
  M.set_bearded_flavor(flavor)
end

-- Switch to previous bearded flavor
function M.prev_bearded_flavor()
  current_bearded_flavor_index = (current_bearded_flavor_index - 2) % #bearded_flavors + 1
  local flavor = bearded_flavors[current_bearded_flavor_index]
  M.set_bearded_flavor(flavor)
end

-- Get current bearded flavor
function M.get_current_bearded_flavor()
  return bearded_flavors[current_bearded_flavor_index]
end


-- Initialize default theme
M.setup()

return M