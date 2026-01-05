# Noice.nvim 配置说明

## 已添加的插件

### folke/noice.nvim
一个实验性插件，完全替换了 Vim 的 `messages`、`cmdline` 和 `popupmenu` UI。

### 配置特性

✅ **Cmdline 增强**
  - 漂亮的命令行界面，替代原生命令行
  - 支持 `cmdline_popup` 模式（更现代的界面）
  - 支持语法高亮（vim 和 lua）
  
✅ **Messages 优化**
  - 将消息显示为通知
  - 支持 `:messages` 历史查看
  - 搜索计数显示为虚拟文本
  
✅ **Popupmenu 美化**
  - 基于 nui.nvim 的现代补全菜单
  - 支持图标显示
  
✅ **LSP 集成**
  - 进度条显示为 mini 视图
  - Hover 文档和签名帮助
  - 自动打开签名帮助
  
✅ **Presets 配置**
  - `bottom_search`: 使用经典底部命令行进行搜索
  - `command_palette`: 将命令行和菜单组合显示
  - `long_message_to_split`: 长消息发送到分屏
  
✅ **历史记录**
  - `:Noice` 或 `:Noice history` 查看消息历史
  - `:Noice last` 查看最后一条消息
  - `:Noice errors` 查看错误消息
  - `:Noice disable/enable` 启用/禁用 Noice

## 快捷键（示例）

### 查看 Noice 命令
```vim
:Noice          -- 查看消息历史（Telescope/Fzf-Lua）
:Noice history   -- 查看完整历史
:Noice last     -- 查看最后一条消息
:Noice errors   -- 查看错误消息
:Noice disable  -- 禁用 Noice
:Noice enable   -- 启用 Noice
```

### 自定义快捷键示例
```vim
-- 查看最后一条消息
vim.keymap.set('n', '<leader>nl', function()
  require('noice').cmd('last')
end, { desc = 'Noice last' })

-- 查看历史记录
vim.keymap.set('n', '<leader>nh', function()
  require('noice').cmd('history')
end, { desc = 'Noice history' })
```

## 依赖关系

- **必需**: `MunifTanjim/nui.nvim` - 用于正确的渲染和多个视图
- **推荐**: `rcarriga/nvim-notify` - 通知视图（已配置）
- **推荐**: `nvim-treesitter` - 用于高亮命令行和 LSP 文档

## 配置位置

插件配置位于: `lua/plugins/ui.lua`

## 视图类型

Noice 提供多种视图：
- **notify**: 通知视图（使用 nvim-notify）
- **popup**: 弹窗视图（使用 nui.nvim）
- **split**: 分屏视图（使用 nui.nvim）
- **virtualtext**: 虚拟文本视图
- **mini**: 精简视图
- **cmdline**: 命令行视图
- **cmdline_popup**: 美化的命令行弹窗

## 更多信息

- [GitHub 仓库](https://github.com/folke/noice.nvim)
- [配置文档](https://github.com/folke/noice.nvim/wiki/Configuration-Recipes)
- 使用 `:checkhealth noice` 检查常见问题