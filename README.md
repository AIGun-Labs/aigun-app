### 核心技术栈

#### 🏗️ 架构与设计模式

- **Clean Architecture** - 分层架构，实现业务逻辑与框架解耦
- **BLoC/Cubit** (`flutter_bloc ^9.0.0`) - 状态管理，实现 UI 与业务逻辑分离
- **Repository Pattern** - 数据访问抽象层
- **UseCase Pattern** - 封装业务用例

#### 🎨 UI 框架

- **Flutter** (`SDK >=3.0.0 <4.0.0`) - 跨平台 UI 框架
- **flutter_screenutil** (`^5.0.0`) - 屏幕适配
- **Material Design 3** - 设计系统
- **Cupertino** - iOS 风格组件

#### 🔄 状态管理

- **flutter_bloc** (`^9.0.0`) - BLoC/Cubit 状态管理
- **Provider** (`^6.1.1`) - 依赖注入和状态共享
- **Equatable** (`^2.0.7`) - 对象比较，优化状态判断

#### 🌐 网络请求

- **Dio** (`^5.4.1`) - HTTP 客户端
- **pretty_dio_logger** (`^1.4.0`) - 网络请求日志
- **fresh_dio** (`^0.4.3`) - Token 刷新拦截器
- **web_socket_channel** (`^2.4.5`) - WebSocket 实时通信

#### 🗺️ 路由导航

- **GoRouter** (`^13.2.0`) - 声明式路由管理
- 支持深链接、路由守卫、嵌套路由

#### 💉 依赖注入

- **GetIt** (`^8.0.0`) - 服务定位器
- 模块化 DI 配置（`core/di/modules/`）

#### 🔐 区块链集成

- **web3dart** (`^2.7.1`) - EVM 链交互（以太坊、BSC、Polygon 等）
- **solana_web3** (`0.1.1`) - Solana 链交互
- **pinenacl** (`^0.6.0`) - 加密库
- **cryptography** (`^2.7.0`) - 加密算法
- **crypto** (`^3.0.6`) - 哈希和加密工具

#### 💾 数据持久化

- **flutter_secure_storage** (`^9.2.0`) - 安全存储（密钥、私钥）
- **shared_preferences** (`^2.3.4`) - 本地键值存储

#### 🎯 数据模型

- **Freezed** (`^2.4.7`) - 不可变数据类生成
- **freezed_annotation** (`^2.4.1`) - Freezed 注解
- **json_serializable** (`^6.7.1`) - JSON 序列化
- **json_annotation** (`^4.9.0`) - JSON 注解

#### 🌍 国际化（i18n）

- **intl** (`^0.20.2`) - 国际化支持
- **flutter_localizations** - Flutter 本地化
- **intl_utils** (`^2.8.7`) - 国际化工具
- 支持语言：中文、英文

#### 🎬 UI 组件库

- **Lottie** (`3.3.1`) - 动画播放
- **dotlottie_loader** (`^0.0.5`) - Lottie 加载器
- **flutter_svg** (`^2.0.16`) - SVG 图片支持
- **cached_network_image** (`^3.4.1`) - 网络图片缓存
- **shimmer** (`^3.0.0`) - 骨架屏加载效果
- **skeletonizer** (`^2.1.0+1`) - 骨架屏组件
- **qr_flutter** (`^4.1.0`) - 二维码生成
- **photo_view** (`^0.15.0`) - 图片查看器
- **easy_image_viewer** (`^1.5.1`) - 图片预览

#### 📊 列表与下拉刷新

- **easy_refresh** (`^3.4.0`) - 下拉刷新和上拉加载
- **pull_to_refresh** (`^2.0.0`) - 刷新组件
- **infinite_scroll_pagination** (`^5.1.1`) - 无限滚动分页
- **loading_more_list** (`^7.1.0`) - 加载更多列表

#### 🎥 多媒体

- **video_player** (`^2.10.0`) - 视频播放
- **chewie** (`^1.12.1`) - 视频播放器 UI
- **flick_video_player** (`^0.9.0`) - 视频播放控制器
- **audioplayers** (`^6.5.1`) - 音频播放

#### 🔔 UI 交互

- **toastification** (`^2.3.0`) - Toast 提示
- **fluttertoast** (`^8.2.12`) - 原生 Toast
- **adaptive_dialog** (`^2.4.2`) - 自适应对话框
- **simple_tooltip** (`^1.2.0`) - 提示气泡
- **flutter_popup** (`^3.3.9`) - 弹窗组件

#### 📈 图表与数据可视化

- **k_chart** (`^0.7.1`) - K 线图表

#### 🛠️ 工具库

- **dartz** (`^0.10.1`) - 函数式编程（Either、Option）
- **decimal** (`^3.2.4`) - 高精度数字计算
- **money2** (`^6.0.3`) - 货币处理
- **timezone** (`^0.10.1`) - 时区处理
- **url_launcher** (`^6.3.2`) - URL 启动器
- **device_info_plus** (`^11.5.0`) - 设备信息
- **package_info_plus** (`^9.0.0`) - 应用信息
- **permission_handler** (`^12.0.1`) - 权限管理
- **path_provider** (`^2.1.5`) - 文件路径
- **connectivity_plus** (`^7.0.0`) - 网络连接状态

#### 📥 下载与更新

- **background_downloader** (`^9.2.6`) - 后台下载
- 自定义 APK 更新模块（`features/update/`）

#### 🐛 错误监控

- **sentry_flutter** (`^9.7.0`) - 错误跟踪和性能监控
- **sentry_dart_plugin** (`^3.1.1`) - Sentry Dart 插件
- **Logger** (`^2.5.0`) - 日志记录

#### 🧪 测试

- **flutter_test** - Widget 测试
- **flutter_lints** (`^4.0.0`) - 代码规范检查

#### 🔧 开发工具

- **build_runner** (`^2.4.8`) - 代码生成工具
- **flutter_gen_runner** (`^5.5.0+1`) - 资源文件生成
- **flutter_launcher_icons** (`^0.14.4`) - 应用图标生成
- **envied** (`^1.2.1`) - 环境变量管理
- **envied_generator** (`^1.1.1`) - 环境变量生成器

#### 🌐 WebView

- **flutter_inappwebview** (`^6.1.5`) - 内嵌浏览器
- **webview_flutter** (`^4.13.0`) - WebView 组件

#### 🎯 其他

- **visibility_detector** (`^0.4.0+2`) - 可见性检测
- **flutter_keyboard_visibility** (`^6.0.0`) - 键盘可见性监听
- **pin_code_fields** (`^8.0.1`) - 验证码输入
- **pinput** (`^5.0.1`) - PIN 码输入
- **auto_size_text** (`^3.0.0`) - 自适应文本大小
- **flutter_confetti** (`^0.5.1`) - 彩带动画效果
- **app_tracking_transparency** (`^2.0.6+1`) - iOS 跟踪透明度

### 树形文件架构（Clean Architecture）

项目采用 **Clean Architecture** 架构模式，按功能模块和分层组织代码：

```
lib/
├── features/                      # 📦 功能模块（按业务领域划分）
│   ├── trending/                  # 热门代币功能模块
│   │   ├── domain/               # 🎯 领域层（业务逻辑）
│   │   │   ├── entities/         # 业务实体
│   │   │   ├── repositories/     # 仓储接口（抽象）
│   │   │   └── usecases/         # 用例（业务场景）
│   │   ├── data/                 # 💾 数据层（数据实现）
│   │   │   ├── models/           # 数据模型（DTO）
│   │   │   ├── repositories/     # 仓储实现
│   │   │   └── sources/          # 数据源（remote/local）
│   │   └── presentation/         # 🎨 表现层（UI）
│   │       ├── pages/            # 页面
│   │       ├── widgets/          # 组件
│   │       └── cubit/            # 状态管理
│   ├── update/                    # 应用更新模块
│   ├── ai_agent/                  # AI 代理模块
│   └── home/                      # 首页模块
│
├── core/                          # 🔧 核心功能（跨模块）
│   ├── di/                       # 依赖注入
│   │   ├── injection_container.dart
│   │   ├── module_repo.dart
│   │   └── modules/              # 模块化 DI 配置
│   ├── router/                   # 路由配置
│   │   ├── app_router.dart       # GoRouter 配置
│   │   └── constants.dart        # 路由常量
│   ├── service_locator.dart      # 服务定位器
│   └── custom_exceptions.dart    # 自定义异常
│
├── data/                          # 💾 全局数据层
│   ├── models/                   # 数据模型（全局使用）
│   │   ├── auth/                 # 认证相关模型
│   │   ├── token/                # 代币相关模型
│   │   ├── wallet/               # 钱包相关模型
│   │   └── api/                  # API 响应模型
│   └── services/                 # 服务层
│       ├── api/                  # API 服务
│       ├── http/                 # HTTP 客户端
│       └── ws/                   # WebSocket 服务
│
├── cubits/                        # 🔄 全局状态管理（Cubit/Bloc）
│   ├── auth/                     # 认证状态
│   ├── user/                     # 用户状态
│   ├── wallet/                   # 钱包状态
│   ├── theme/                    # 主题状态
│   └── language/                 # 语言状态
│
├── screens/                       # 📱 页面（旧架构，逐步迁移至 features）
│   ├── auth/                     # 认证相关页面
│   ├── wallet/                   # 钱包页面
│   ├── token_detail/             # 代币详情页
│   └── trade/                    # 交易页面
│
├── widgets/                       # 🧩 共享组件
│   ├── button/                   # 按钮组件
│   ├── input/                    # 输入框组件
│   ├── dialog/                   # 对话框组件
│   ├── loading_indicator/        # 加载指示器
│   └── token/                    # 代币相关组件
│
├── utils/                         # 🛠️ 工具函数
│   ├── validators/               # 表单验证器
│   ├── format/                   # 格式化工具
│   ├── storage/                  # 本地存储
│   ├── extensions/               # Dart 扩展
│   └── web3/                     # Web3 工具
│
├── themes/                        # 🎨 主题配置
│   ├── theme.dart                # 主题定义
│   ├── colors.dart               # 颜色定义
│   ├── button_theme.dart         # 按钮主题
│   └── input_theme.dart          # 输入框主题
│
├── config/                        # ⚙️ 配置文件
│   ├── env/                      # 环境配置
│   │   ├── env.dart              # 环境管理
│   │   └── env.g.dart            # 生成的环境变量
│   ├── chain.dart                # 区块链配置
│   └── url.dart                  # URL 配置
│
├── l10n/                          # 🌍 国际化
│   ├── intl_zh.arb               # 中文翻译
│   ├── intl_en.arb               # 英文翻译
│   └── l10n.dart                 # 生成的国际化代码
│
├── enums/                         # 📋 枚举定义
│   ├── trade_mode.dart           # 交易模式
│   ├── storage_key.dart          # 存储键
│   └── validation_error.dart     # 验证错误
│
├── gen/                           # 🤖 自动生成的代码
│   └── assets.gen.dart           # 资源文件引用
│
├── app.dart                       # 应用入口
└── main.dart                      # 主函数
```

#### Clean Architecture 分层说明

**1. Domain Layer（领域层）** - 纯业务逻辑，不依赖外部框架

- **Entities**: 业务实体，核心数据结构
- **Repositories**: 仓储接口（抽象），定义数据操作规范
- **UseCases**: 用例，封装具体业务场景（如：获取热门代币）

**2. Data Layer（数据层）** - 数据来源和实现

- **Models**: 数据传输对象（DTO），通常带有 JSON 序列化
- **Repositories**: 仓储实现，实现 Domain 层定义的接口
- **Sources**: 数据源（Remote API / Local Database）

**3. Presentation Layer（表现层）** - UI 和用户交互

- **Pages**: 页面级组件
- **Widgets**: UI 组件
- **Cubit/Bloc**: 状态管理，处理 UI 逻辑

#### 依赖规则

```
Presentation → Domain ← Data
     ↓           ↓        ↓
  Cubit    →  UseCase → Repository
```

- **Presentation** 依赖 **Domain**
- **Data** 依赖 **Domain**
- **Domain** 不依赖任何层（纯业务逻辑）
- 依赖注入通过 `core/di/` 管理

### 关于国际化

安装编辑器插件 `Flutter Intl`

```bash
# 生成 `l10n.dart` 文件
flutter gen-l10n
```

### 关于冻结 model

使用 `Freezed` 库进行数据模型定义，在 `lib/data/models` 目录下进行配置。

- 可以使用 VSCode 插件 `Freezed` 进行代码生成

```shell
# 监听文件变化，自动生成 `*.freezed.dart` 文件
dart run build_runner watch

# 直接生成 `*.freezed.dart` 文件，不监听
flutter pub run build_runner build --delete-conflicting-outputs
```

### 开发调试

#### 环境配置

项目使用 `envied` 进行环境管理，支持以下环境：

- **development**: 开发环境（默认）
- **production**: 生产环境

环境配置文件：

- `.env.development` - 开发环境配置
- `.env.production` - 生产环境配置

#### 本地开发调试

```bash
# 1. 安装依赖
flutter pub get

# 2. 生成环境配置文件
dart run build_runner build --delete-conflicting-outputs

# 3. 开发环境调试（默认）
flutter run

# 或指定开发环境
flutter run --dart-define=ENV=development --flavor staging

# 4. 生产环境调试
flutter run --dart-define=ENV=production --flavor production
```

#### 生成代码文件

项目使用 `freezed` 和 `build_runner` 进行代码生成：

```bash
# 监听文件变化，自动生成代码
flutter pub run build_runner watch

# 一次性生成所有代码文件
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 国际化文件生成

```bash
flutter gen-l10n
```

### 版本管理

版本号在 `pubspec.yaml` 中管理：

```yaml
version: 1.0.16 # 格式：major.minor.patch
```

更新版本号后，需要：

1. 更新 `pubspec.yaml` 中的 `version` 字段
2. 更新 `CHANGELOG.md` 记录变更内容
3. 提交代码并打 tag（如 `v1.0.16`）


### 自动化部署测试版
1. 更新 `CHANGELOG.md` 记录变更内容
2. git switch staging 
3. git merge dev
4. git push
5. git push build