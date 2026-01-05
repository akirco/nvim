# 主题配置更新说明

## 更改内容

### 1. 删除其他主题
- **删除**: arctic.nvim 主题
- **删除**: gruvbox.nvim 主题
- **保留**: bearded-nvim 主题（唯一的主题）

### 2. 简化主题切换
- 移除了多主题切换功能
- 现在只在 bearded 主题的不同风味之间切换
- 支持 36 种 bearded 风味

### 3. 快捷键配置
- `<leader>tt` - 切换到下一个 bearded 风味
- `<leader>th` - 切换到下一个 bearded 风味（同上）

### 4. 持久化功能
- 状态文件位置: `~/.local/state/nvim/colorscheme-state.json`
- 自动保存当前选择的风味索引
- 下次启动时自动恢复上次选择的风味

## Bearded 风味列表

### Original favorites
1. arc
2. arc-blueberry
3. oceanic
4. monokai-terra
5. solarized-dark
6. hc-flurry
7. milkshake-raspberry

### Black series
8. black-&-amethyst
9. black-&-amethyst-soft
10. black-&-diamond
11. black-&-diamond-soft
12. black-&-emerald
13. black-&-emerald-soft
14. black-&-gold
15. black-&-gold-soft
16. black-&-ruby
17. black-&-ruby-soft

### Monokai series
18. monokai-black
19. monokai-metallian
20. monokai-stone

### Solarized series
21. solarized-light
22. solarized-reversed

### Oceanic series
23. oceanic-reversed

### Stained series
24. stained-purple
25. stained-blue

### Vivid series
26. vivid-black
27. vivid-light
28. vivid-purple

### Other popular
29. earth
30. coffee
31. coffee-reversed
32. themianopia
33. void

## API 函数

### `M.setup()`
初始化主题配置，加载保存的状态并应用主题。

### `M.toggle()`
切换到下一个 bearded 风味，并保存状态。

### `M.next_bearded_flavor()`
切换到下一个 bearded 风味，并保存状态。

### `M.prev_bearded_flavor()`
切换到上一个 bearded 风味，并保存状态。

### `M.set_bearded_flavor(flavor)`
设置指定的 bearded 风味。
- 参数: `flavor` - 风味名称（字符串）
- 保存状态

### `M.get_current_bearded_flavor()`
获取当前应用的 bearded 风味名称。
- 返回: 当前风味名称（字符串）

## 使用示例

```lua
-- 在配置中使用
require('config.colorscheme').setup()

-- 切换到下一个风味
require('config.colorscheme').toggle()

-- 设置特定风味
require('config.colorscheme').set_bearded_flavor('solarized-dark')

-- 获取当前风味
local current_flavor = require('config.colorscheme').get_current_bearded_flavor()
```

## 测试结果

✅ 主题切换功能正常
✅ 状态文件正确创建和读取
✅ 重启后自动恢复上次选择
✅ 无状态文件时使用默认风味
✅ 所有 36 种风味可以正常切换