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
- **Equatable** - 对象比较优化

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
- **easy_refresh** - 列表刷新
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
```bash
# 开发模式
flutter run --dart-define=ENV=development --flavor staging

# 生产模式
flutter run --dart-define=ENV=production --flavor production
```

#### 构建发布
```bash
# 开发包
flutter build apk --release --dart-define=ENV=development --flavor staging

# 生产包
flutter build apk --release --dart-define=ENV=production --flavor production
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
