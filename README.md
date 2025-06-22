# HarmonyOS 应用包名提取工具

一个用于从华为应用商城分享链接中提取应用包名的 HarmonyOS 应用。

## 📱 功能特点

- 🔍 **智能提取**：自动从华为应用商城分享链接中提取应用包名
- 📋 **一键复制**：快速复制提取的包名到剪贴板
- 🚀 **分享接入**：作为系统分享目标，支持从任意应用分享文本/链接
- ⚡ **高效处理**：基于正则表达式的快速URL解析

## 🎯 使用场景

- 开发者需要快速获取华为应用商城中应用的包名
- ClashBox代理工具快速获取黑白名单应用的包名
- 应用分析和研究需要
- 自动化测试中需要获取应用标识

## 📖 使用教程

### 方法一：通过分享功能使用

1. **打开华为应用商城**，找到目标应用
2. **点击分享按钮**，选择"包名解析/AppBundleNameForShared"应用
3. **自动提取包名**，应用会自动解析并显示包名
4. **一键复制**，点击复制按钮将包名复制到剪贴板

![使用教程1](https://github.com/user-attachments/assets/014d02cf-93ca-4bae-9df0-dbd232eeb647)

![使用教程2](https://github.com/user-attachments/assets/39fceabb-f993-4aea-8137-28a967a2d4c9)

![使用教程3](https://github.com/user-attachments/assets/a0a3427e-9ca6-4410-bcae-e3a70e1b4122)

### 方法二：直接启动应用

直接启动应用会显示使用指南，按照界面提示操作即可。

## 🔧 技术实现

### 核心功能模块

#### 1. URL解析工具 (`UrlUtils.ets`)
```typescript
/**
 * 从华为应用商店URL中提取应用包名
 * @param url 华为应用商店的完整URL字符串
 * @returns 应用包名，如果提取失败返回空字符串
 */
static extractPackageName(url: string): string
```

#### 2. 分享能力 (`SharePageAbility.ets`)
- 注册为系统分享目标
- 支持文本和超链接类型的数据接收
- 自动启动分享处理页面

#### 3. 分享处理页面 (`ShareUIPage.ets`)
- 解析接收到的分享数据
- 提取应用包名并显示
- 提供一键复制功能

### 技术栈

- **开发框架**：API 5.0.5(17)
- **编程语言**：ArkTS
- **UI框架**：ArkUI
- **构建工具**：Hvigor

### 关键API使用

- `@kit.ShareKit`：系统分享功能接入
- `@kit.BasicServicesKit`：剪贴板操作
- `@kit.AbilityKit`：Ability 生命周期管理
- `@kit.ArkData`：统一数据类型处理

## 🚀 快速开始

### 环境要求

- HarmonyOS NEXT Developer Preview2 或更高版本
- DevEco Studio NEXT Developer Preview2 或更高版本
- Node.js 18.0.0 或更高版本

### 安装步骤

1. **克隆项目**
```bash
git clone https://github.com/SummerKaze/HMOS-AppBundleNameForShared.git
cd HMOS-AppBundleNameForShared
```

2. **安装依赖**
```bash
ohpm install
```

3. **编译运行**
```bash
hvigor --mode module -p product=default assembleHap
```

4. **安装到设备**
   - 使用 DevEco Studio 或 HDC 工具安装生成的 HAP 包

## 📁 项目结构

```
AppGalleryCom/
├── AppScope/                 # 应用级配置
├── entry/                    # 主入口模块
│   ├── src/main/ets/
│   │   ├── entryability/     # 主Ability
│   │   ├── sharepageability/ # 分享处理Ability
│   │   ├── pages/            # 页面文件
│   │   │   ├── Index.ets     # 主页面
│   │   │   └── ShareUIPage.ets # 分享处理页面
│   │   └── utils/            # 工具类
│   │       └── UrlUtils.ets  # URL解析工具
│   └── src/main/resources/   # 资源文件
├── build-profile.json5       # 构建配置
└── oh-package.json5         # 包管理配置
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进项目！

## 📄 许可证

本项目基于 MIT 许可证开源 - 详见 [LICENSE](LICENSE) 文件

## 🔗 相关链接

- [HarmonyOS 开发者文档](https://developer.harmonyos.com/)
- [ArkTS 语言参考](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-get-started-0000001504769321-V3)
- [HarmonyOS 分享开发指南](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/share-kit-guidelines-0000001774279525-V3)

---

💡 **提示**：如果您在使用过程中遇到问题，请查看应用内的使用指南或提交 Issue。
