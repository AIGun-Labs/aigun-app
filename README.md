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
├── main.dart                         # 🚀 应用启动入口
├── app.dart                          # 🏠 应用根组件
├── core/                             # 🔧 核心层（业务无关）
│   ├── di/                          # 依赖注入
│   ├── network/                     # 网络层
│   ├── storage/                     # 存储层
│   ├── router/                      # 路由管理
│   ├── theme/                       # 主题配置
│   ├── utils/                       # 核心工具
│   └── constants/                   # 全局常量
├── features/                         # 📦 功能模块（按业务划分）
│   ├── authentication/              # 用户认证模块
│   │   ├── domain/                  # 领域层
│   │   │   ├── entities/           # 业务实体
│   │   │   ├── repositories/        # 抽象接口
│   │   │   └── usecases/           # 业务用例
│   │   ├── data/                    # 数据层
│   │   │   ├── models/             # 数据模型
│   │   │   ├── repositories/        # 接口实现
│   │   │   └── datasources/         # 数据源
│   │   └── presentation/            # 表现层
│   │       ├── pages/              # 页面
│   │       ├── widgets/            # 组件
│   │       ├── blocs/              # 状态管理
│   │       └── controllers/        # 控制器
│   ├── settings/                    # 设置模块
│   └── ...
├── shared/                           # 🔄 共享层（跨模块使用）
│   ├── data/                        # 共享数据
│   │   ├── models/                 # 通用数据模型
│   │   └── services/               # 共享服务
│   ├── domain/                      # 共享业务逻辑
│   ├── presentation/                # 共享UI组件
│   │   ├── widgets/                # 通用组件
│   │   ├── themes/                 # 主题定义
│   │   └── animations/             # 动画组件
│   └── utils/                       # 共享工具
├── config/                           # ⚙️ 配置层
│   ├── environment/                 # 环境配置
│   ├── routes/                      # 路由配置
│   └── constants/                   # 业务常量
├── l10n/                            # 🌍 国际化
│   ├── arb/                         # 翻译文件
│   └── generated/                   # 生成的代码
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

# 运行开发环境
flutter run --dart-define=ENV=development
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
  3. `git push build`
- **正式版**：
  1. `git switch release` 
  2. `git merge dev` 
  3. `git push build` 
  4. `git tag vx.x.x` 
  5. `git push build vx.x.x`
