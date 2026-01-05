# Nvim 配置重组总结

## 新的目录结构

```
lua/
├── core/                 # 核心配置
│   ├── init.lua         # 核心配置入口
│   ├── options.lua      # vim.opt 设置
│   ├── keymaps.lua      # 键盘映射
│   └── autocmds.lua     # 自动命令
├── config/              # 其他配置
│   └── colorscheme.lua  # 主题配置
├── lsp/                 # LSP 服务器配置
│   ├── init.lua         # LSP 初始化
│   └── *.lua           # 各语言服务器配置
└── plugins/             # 插件配置（按功能分类）
    ├── init.lua         # 插件管理器设置
    ├── editor.lua       # 编辑器基础插件
    ├── ui.lua          # UI 相关插件
    ├── lsp.lua         # LSP 相关插件
    ├── telescope.lua   # 搜索相关插件
    ├── git.lua         # Git 相关插件
    └── tools.lua       # 工具类插件
```

## 配置加载顺序

1. `init.lua` - 主入口文件
2. `require('core')` - 加载核心配置
   - options.lua
   - keymaps.lua
   - autocmds.lua
3. Lazy 插件管理器加载 `plugins/` 目录下的所有分类插件配置
4. `VimEnter` 事件 - 加载主题配置 `require('config.colorscheme')`
5. `VeryLazy` 事件 - 加载 LSP 配置 `require('lsp')`

### 延迟加载机制

- **主题配置**：使用 `VimEnter` 事件确保所有主题插件已经加载
- **LSP 配置**：使用 `VeryLazy` 事件确保依赖插件（如 `blink.cmp`）已经加载
- **Capabilities 设置**：监听 `LazyLoad` 事件，在 `blink.cmp` 加载后设置 LSP capabilities

## 主要变更

### 核心配置重组
- 将 `lua/config/settings.lua` 移动到 `lua/core/options.lua`
- 将 `lua/config/keymaps.lua` 移动到 `lua/core/keymaps.lua`
- 将 `lua/config/autocmds.lua` 移动到 `lua/core/autocmds.lua`
- 创建 `lua/core/init.lua` 作为核心配置的统一入口

### 插件配置分类
 将原有的34个单独的插件配置文件重组为6个分类文件：
 - **editor.lua** - 包含编辑器基础插件（minipairs、miniai、surround、comment等）
 - **ui.lua** - 包含UI相关插件（lualine、bufferline、colorizer、whichkey、noice、nvim-notify等）
 - **lsp.lua** - 包含LSP相关插件（mason、lspconfig、conform、lint、treesitter等）
 - **telescope.lua** - 包含搜索相关插件（telescope、telescope-file-browser等）
 - **git.lua** - 包含Git相关插件（gitsigns、fugitive等）
 - **tools.lua** - 包含工具类插件（toggleterm、project、search-replace等）

### LSP 配置优化
- 简化 `lua/lsp/init.lua`，只保留配置文件加载逻辑
- 将重复的LSP配置移除（现在在 `plugins/lsp.lua` 中统一配置）
- 保留各语言服务器特定的配置文件（如 `lua/lsp/gopls.lua`）

### 插件管理器改进
- 更新 `lua/plugins/init.lua`，使用新的分类结构加载插件
- 添加性能优化配置
- 添加更改检测和更新检查配置

## 优势

1. **结构清晰** - 按功能分类组织，更容易找到和修改配置
2. **减少文件数量** - 从34个单独的插件配置文件减少到6个分类文件
3. **更好的维护性** - 相关配置集中管理，减少维护难度
4. **更快的加载** - 分类加载可以提高插件的加载效率
5. **更易于扩展** - 添加新插件时更容易找到合适的分类

## 使用说明

### 添加新插件
根据插件类型，将其配置添加到对应的分类文件中：
- 编辑器增强 → `plugins/editor.lua`
- UI相关 → `plugins/ui.lua`
- LSP相关 → `plugins/lsp.lua`
- 搜索相关 → `plugins/telescope.lua`
- Git相关 → `plugins/git.lua`
- 工具类 → `plugins/tools.lua`

### 添加新LSP服务器
1. 在 `lua/lsp/` 目录下创建新的配置文件（如 `python.lua`）
2. 在 `plugins/lsp.lua` 的 `mason-lspconfig` 配置中添加服务器名称

### 修改核心配置
- Vim 选项 → `lua/core/options.lua`
- 键盘映射 → `lua/core/keymaps.lua`
- 自动命令 → `lua/core/autocmds.lua`

## 备份

原始配置已备份到 `backup-before-reorganization` 分支，如需回退：
```bash
git checkout backup-before-reorganization
```