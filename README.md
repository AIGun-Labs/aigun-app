# AIGun - AI 自动化交易平台

AIGun 是一个颠覆性的创新 AI 自动化交易平台。它利用先进的人工智能算法，在多个市场实现自动交易策略，为用户提供无缝且智能的交易体验。

## 🚀 快速开始 (Getting Started)

按照以下步骤配置开发环境并运行项目。

### 1. 环境准备 (Prerequisites)

在开始之前，请确保您的机器上已安装 **Flutter SDK**。

#### 🍎 macOS 安装 Flutter
1.  **下载 SDK**:
    - 访问 [Flutter 官网](https://docs.flutter.dev/get-started/install/macos) 下载最新稳定版。
    - 解压文件到目标目录（例如 `~/development/flutter`）。
2.  **配置环境变量**:
    - 将 Flutter 添加到 PATH 中。在终端运行：
      ```bash
      export PATH="$PATH:`pwd`/flutter/bin"
      ```
    - 建议将此命令添加到您的 Shell 配置文件（如 `~/.zshrc` 或 `~/.bash_profile`）中以便永久生效。
3.  **检查环境**:
    - 运行 `flutter doctor` 检查并安装缺失的依赖（如 Xcode, Android Studio, CocoaPods 等）。

#### 🪟 Windows 安装 Flutter
1.  **下载 SDK**:
    - 访问 [Flutter 官网](https://docs.flutter.dev/get-started/install/windows) 下载最新稳定版 zip 包。
    - 解压到非系统权限目录（例如 `C:\src\flutter`）。
2.  **配置环境变量**:
    - 在“开始”搜索栏输入“env”并选择“编辑系统环境变量”。
    - 点击“环境变量” -> 在“用户变量”下找到 `Path` -> 点击“编辑” -> “新建”，输入 `C:\src\flutter\bin`。
3.  **检查环境**:
    - 打开 PowerShell 或命令提示符，运行 `flutter doctor` 检查依赖。

### 核心技术栈

#### 🏗️ 架构与设计模式
- **Clean Architecture** - 分层架构，实现业务逻辑与框架解耦
- **BLoC/Cubit** (flutter_bloc) - 状态管理
- **Repository Pattern** - 数据访问抽象层
- **UseCase Pattern** - 封装业务用例

#### 🎨 UI 框架
- **Flutter** (SDK >=3.0.0 <4.0.0) - 跨平台 UI 框架
- **flutter_screenutil** - 屏幕适配
- **Material Design 3** & **Cupertino** - 设计系统

#### 🔄 状态管理
- **flutter_bloc** - BLoC/Cubit 状态管理
- **Provider** - 依赖注入

#### 🌐 网络与数据
- **Dio** - HTTP 客户端
- **web3dart** - 区块链集成 (EVM/Solana)
- **Freezed** - 不可变数据类
- **flutter_secure_storage** - 安全存储

#### 🗺️ 路由与工具
- **GoRouter** - 声明式路由
- **GetIt** - 依赖注入
- **intl** - 国际化支持
- **Lottie** - 动画组件

#### 📊 UI 组件库
- **cached_network_image** - 图片缓存
- **qr_flutter** - 二维码生成
- **toastification** - 提示组件

### 项目架构

采用行业标准的 **Clean Architecture** + **Feature-Driven Development** 设计模式：

```

lib/
├── main.dart                         # 🚀 启动入口
├── app.dart                          # 🏠 MaterialApp 配置
├── di/                               # 💉 依赖注入 (Service Locator)
├── config/                           # ⚙️ 静态配置 (Env, Theme, Routes Path)
│   ├── theme/                       #    [全局主题] ThemeData 配置
│   └── env/
│   └── routes/
│       ├── app_router.dart      # GoRouter 实例配置 (引用了 Features 的 Pages)
│       └── route_names.dart     # 路由路径常量 (static const String login = '/login';)│
│
│
├── core/                             # 🧠 内核层 (纯 Dart，无 Flutter 依赖，无第三方库)
│   ├── error/                        #   Failures, Exceptions 定义
│   ├── usecases/                     #   UseCase 抽象基类
│   ├── types/                        #   通用类型定义 (e.g. Either, Result)
│   └── utils/                        #   纯逻辑工具（Dart） (日期计算, 验证器)
│   └── constants/                    #   [逻辑常量] Limits, Regex
│
├── infrastructure/                   # 🔧 基础设施层 (具体的“硬”技术实现)
│   ├── networking/                   #   🔴 网络客户端封装 (Dio/Http Client)
│   │   ├── api_client.dart           #     统一配置了拦截器、BaseURL 的实例
│   │   └── interceptors/
│   ├── storage/                      #   🔴 本地存储封装 (Hive/SP/Isar)
│   │   ├── database_service.dart     #     KV 存储或 DB 的抽象实现
│   │   └── secure_storage.dart       #     加密存储实现
│   ├── services/                     #   🔴 第三方服务具体实现
│   │   ├── logger_service.dart       #     日志库封装
│   │   ├── analytics_service.dart    #     Firebase/Umeng 封装
│   │   └── permission_service.dart   #     权限请求封装
│   ├── device/                       #   🔴 设备功能
│   │   └── connection_checker.dart   #     网络连接状态检查
│   └── router/
│       ├── navigation_service.dart      # 接口实现 (封装 go(), push() 等)
│       └── app_navigator_observer.dart  # 路由监听 (用于埋点)│
│
│
├── l10n/                            # 🌍 [国际化] 顶级目录
│   ├── arb/
│   └── generated/│
│
│
├── shared/                           # 🔄 共享层 (业务与 UI 的公共部分)
│   ├── constants/                    #    [资源常量] Assets, StorageKeys
│   ├── domain/                       #   🔵 共享领域对象 (跨模块的业务实体)
│   │   ├── entities/
│   │   │   └── user_entity.dart      #     (例如：User 对象要在 个人中心/聊天/首页 到处用)
│   │   └── value_objects/            #     (例如：Email, PhoneNumber 对象)
│   ├── data/                         #   🔵 共享数据模型 (DTOs)
│   │   └── models/
│   │       └── user_model.dart       #     UserEntity 的 JSON 序列化类
│   ├── presentation/                 #   🔵 共享 UI (设计系统 Design System)
│   │   ├── widgets/                  #     原子组件 (Buttons, Inputs, Cards)
│   │   │   ├── app_button.dart
│   │   │   └── app_text_field.dart
│   │   ├── dialogs/                  #     通用弹窗 (Toast, Loading, Alert)
│   │   └── layouts/                  #     通用布局 (ErrorView, EmptyView)
│   └── utils/                        #   🔵 Flutter 相关工具
│       └── ui_helpers.dart           #     (屏幕适配, 颜色转换)
│ 
│ 
├── features/                         # 📦 功能模块（按业务划分）
│   ├── authentication/              # 用户认证模块
│   │   ├── domain/                  # 领域层
│   │   │   ├── entities/           # 业务实体
│   │   │   ├── repositories/        # 抽象接口
│   │   │   └── usecases/           # 业务用例
│   │   ├── data/                    # 数据层
│   │   │   ├── models/             # 数据模型
│   │   │   ├── repositories/        # 接口实现
│   │   │   └── datasources/         # 数据源 ⚠️ 这里直接调用 infrastructure 中的 ApiClient
│   │   └── presentation/            # 表现层
│   │       ├── pages/              # 页面
│   │       ├── widgets/            # 组件
│   │       ├── blocs/              # 状态管理
│   │       └── controllers/        # 控制器
│   ├── settings/                    # 设置模块
│   └── ...
└── test/                            # 🧪 测试
    ├── unit/                        # 单元测试
    ├── widget/                      # 组件测试
    └── integration/                 # 集成测试

```

#### 架构分层说明

**1. Core Layer（核心层）**
- 业务无关的基础设施
- 可被任何层依赖
- 包含网络、存储、路由等核心功能

**2. Features Layer（功能层）**
- 按业务领域划分的独立模块
- 每个功能模块都是独立的垂直切片
- 遵循 Clean Architecture 的三层架构

**3. Shared Layer（共享层）**
- 跨模块共享的代码
- 不应包含具体业务逻辑
- 为功能模块提供通用能力

**4. Config Layer（配置层）**
- 应用配置和常量
- 环境相关的设置
- 路由定义

#### 依赖规则

```
┌─────────────────┐
│   Presentation  │ ← Features Layer
├─────────────────┤
│     Domain      │ ← Business Logic
├─────────────────┤
│      Data       │ ← Data Access
├─────────────────┤
│      Core       │ ← Infrastructure
└─────────────────┘

依赖方向：外层 → 内层
禁止：内层依赖外层
```

#### 设计原则

- **SOLID原则**: 单一职责、开闭原则等
- **依赖倒置**: 抽象不依赖实现
- **关注点分离**: 每个模块职责明确
- **可测试性**: 架构支持单元测试

### 开发指南

#### 环境配置
支持环境：`development`（开发）、`production`（生产）

#### 本地开发
```bash
# 安装依赖
flutter pub get

# 生成代码
flutter pub run build_runner build --delete-conflicting-outputs

# 生成国际化
flutter gen-l10n

```

#### 开发调试
环境切换更改main.dart下的environment
```bash
# 开发模式
flutter run --flavor staging

# 生产模式
flutter run --flavor production
```

#### 构建发布
```bash
# 开发包
flutter build apk --release --flavor staging --target lib/main_staging.dart

# 生产包
flutter build apk --release --flavor production --target lib/main_production.dart

#Play版本生产包
flutter build appbundle --release --flavor play --target lib/main_play.dart --dart-define=ENABLE_INNER_UPDATE=false

```

#### 代码生成
```bash
# Freezed 模型
flutter pub run build_runner watch

# 一次性生成
flutter pub run build_runner build --delete-conflicting-outputs
```

### 版本管理
版本号在 `pubspec.yaml` 中维护，更新时同步修改 CHANGELOG 文件。

#### 自动化部署
- **测试版**：
  1. `git switch staging` 
  2. `git merge dev` 
  3. `git push build -f`
- **正式版**：
  1. `git switch release` 
  2. `git merge dev` 
  3. `git push build` 
  4. `git tag vx.x.x` 
  5. `git push build vx.x.x -f`
