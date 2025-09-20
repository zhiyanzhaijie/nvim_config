# 极简 Markdown 配置

## 🎯 配置原则

遵循 SOLID 原则，只保留核心功能：
- ✅ 编辑器内渲染美化
- ❌ 删除预览功能
- ❌ 删除语法检查
- ❌ 删除诊断警告

## 📁 配置文件

1. `lua/plugins/markdown.lua` - 渲染插件配置
2. `lua/plugins/markdown-disable-lint.lua` - 禁用语法检查
3. `lua/config/markdown.lua` - 编辑器选项设置

## 🚀 功能

### 唯一功能：编辑器内渲染
- **键绑定**: `<leader>um` (通常是 `空格+u+m`)
- **效果**: 美化标题、代码块、列表等
- **插件**: render-markdown.nvim

## ✨ 特点

- **极简**: 只有一个功能
- **无干扰**: 无语法警告
- **性能**: 最小资源占用
- **专注**: 纯粹的写作体验

## 🔧 已删除的功能

- ❌ `markdown-preview.nvim` 及其 Node.js 依赖
- ❌ `<leader>cp` 预览键绑定
- ❌ marksman LSP 语法检查
- ❌ conform.nvim markdown 格式化
- ❌ nvim-lint markdown 检查
- ❌ 拼写检查
- [ ] 诊断警告
- [x] sdf1

## 💡 使用

1. 打开任意 `.md` 文件
2. 按 `空格+u+m` 切换渲染显示
3. 享受纯净的写作体验

配置已经完全符合你的需求：最简单、无干扰的 Markdown 编辑环境。
