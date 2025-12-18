<div align="center">
  <h1>🏷️ HarmonyOS 应用包名提取工具</h1>
  <p>
    <strong>一个强大的 HarmonyOS 应用，专为从华为应用商城分享链接中提取应用包名而设计</strong>
  </p>
  
  <p>
    <img alt="HarmonyOS NEXT" src="https://img.shields.io/badge/HarmonyOS-NEXT-blue?style=for-the-badge&logo=huawei&logoColor=white"/>
    <img alt="ArkTS" src="https://img.shields.io/badge/ArkTS-TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white"/>
    <img alt="License" src="https://img.shields.io/badge/License-Apache%202.0-blue?style=for-the-badge"/>
    <img alt="Version" src="https://img.shields.io/badge/Version-1.1.0-orange?style=for-the-badge"/>
  </p>
  
  <p>
    <a href="README_EN.md">🇺🇸 English</a> | 
    <a href="README.md">🇨🇳 中文</a>
  </p>
</div>

## ✨ 功能特性

> 🚀 **现代化设计** - 采用鸿蒙 NEXT 原生设计语言，美观流畅的用户界面
> 
> ⚡ **极速解析** - 基于高效正则表达式引擎，毫秒级包名提取
> 
> 📱 **系统集成** - 深度融入 HarmonyOS 分享系统，无缝使用体验
> 
> 🎯 **智能识别** - 自动识别华为应用商城链接并精准提取包名信息
> 
> 🌫️ **毛玻璃效果** - 滚动时头部动态毛玻璃效果，提升视觉体验
> 
> 🥚 **彩蛋互动** - 隐藏的署名彩蛋，增加用户探索乐趣

<details>
<summary><strong>🔍 核心功能详解</strong></summary>

- **🔗 智能链接解析**：自动从华为应用商城分享链接中提取应用包名
- **📋 一键复制操作**：点击即可将包名复制到系统剪贴板
- **🚀 系统分享集成**：作为系统分享目标，支持从任意应用分享文本/链接
- **⚡ 高性能处理**：基于优化的正则表达式引擎，实现毫秒级解析
- **🎨 现代化界面**：采用鸿蒙设计语言，提供流畅的动效体验
- **🔄 智能状态管理**：实时反馈解析状态，提升用户体验
- **🌫️ 动态毛玻璃**：滚动时头部自动启用毛玻璃效果，增强视觉层次
- **🥚 隐藏彩蛋**：连续点击底部区域5次可触发署名彩蛋显示
- **🎯 应用市场跳转**：一键打开华为应用市场，便捷访问应用商店

</details>

## 🎯 应用场景

<table>
<tr>
<td width="50%">

### 👨‍💻 开发者工具
- 快速获取应用商城中应用的包名
- 应用分析和竞品研究
- 自动化测试脚本编写
- 应用元数据收集

</td>
<td width="50%">

### 🛡️ 代理工具配置
- ClashBox 黑白名单配置
- 网络代理规则设置
- 应用流量分类管理
- 精准应用控制

</td>
</tr>
</table>

## 📖 使用指南

### 🚀 快速开始

<details>
<summary><strong>方法一：通过系统分享使用（推荐）</strong></summary>

1. **🛒 打开华为应用商城**
   - 浏览或搜索您需要获取包名的应用

2. **📤 点击分享按钮**  
   - 在应用详情页点击分享图标
   - 选择 "包名解析/AppBundleNameForShared" 应用

3. **⚡ 自动提取包名**
   - 应用会自动解析链接并显示包名
   - 支持实时状态反馈

4. **📋 一键复制使用**
   - 点击复制按钮将包名复制到剪贴板
   - 可直接粘贴到其他应用中使用

</details>

<details>
<summary><strong>方法二：直接启动应用</strong></summary>

直接启动应用会显示详细的使用指南界面，包括：
- 📝 完整的步骤说明
- 🖼️ 直观的使用示例截图  
- 🔗 快速访问相关工具链接
- 🎯 一键打开应用市场功能
- 🌫️ 体验毛玻璃滚动效果
- 🥚 发现隐藏的彩蛋功能

</details>

## 🛠️ 技术架构

<table>
<tr>
<td><strong>🏗️ 开发框架</strong></td>
<td>HarmonyOS NEXT API 5.0.5(17)</td>
</tr>
<tr>
<td><strong>💻 编程语言</strong></td>
<td>ArkTS (TypeScript 衍生)</td>
</tr>
<tr>
<td><strong>🎨 UI 框架</strong></td>
<td>ArkUI 声明式开发范式</td>
</tr>
<tr>
<td><strong>🔧 构建工具</strong></td>
<td>Hvigor 构建系统</td>
</tr>
<tr>
<td><strong>📦 包管理器</strong></td>
<td>ohpm (OpenHarmony Package Manager)</td>
</tr>
</table>

### 🏛️ 架构亮点

- **🎯 模块化设计**：清晰的代码结构，便于维护和扩展
- **🚀 性能优化**：ArkTS 编译优化确保运行时效率  
- **🔄 状态管理**：使用 @State 装饰器实现响应式状态管理
- **🎨 动画系统**：流畅的过渡动画，提升用户体验
- **🌫️ 视觉效果**：动态毛玻璃效果，增强界面层次感

## 🤝 贡献指南

我们欢迎所有形式的贡献！如果您想为项目做出贡献，请：

1. **🍴 Fork 项目** 到您的 GitHub 账户
2. **🌿 创建功能分支** (`git checkout -b feature/AmazingFeature`)
3. **💾 提交更改** (`git commit -m 'Add some AmazingFeature'`)
4. **📤 推送分支** (`git push origin feature/AmazingFeature`) 
5. **🔄 提交 Pull Request**

### 🐛 问题反馈

如果您发现任何问题或有改进建议，请：
- 📝 [提交 Issue](../../issues)
- 💬 详细描述问题或建议
- 🖼️ 如果可能，请附上截图

## 📄 开源许可

本项目基于 **Apache 2.0 许可证** 开源 - 详见 [LICENSE](LICENSE) 文件

```
Apache License 2.0 - 您可以自由使用、修改和分发此软件
```

---

<div align="center">
  <p>
    <strong>Made with ❤️ for HarmonyOS by SummerKaze</strong>
  </p>
  <p>
    如果这个项目对您有帮助，请给我们一个 ⭐️
  </p>
  <p>
    <em>💡 提示：连续点击应用底部区域5次可发现隐藏彩蛋！</em>
  </p>
</div>
