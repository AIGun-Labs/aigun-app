### 核心技术栈

- Flutter
- Bloc
- Dio
- GoRouter

### 树形文件架构

```
lib
├── cubits // 公共逻辑
│   ├── auth
│   │   ├── auth_bloc.dart          // 管理用户认证状态的BLoC
│   │   ├── auth_event.dart         // 定义认证相关的事件
│   │   └── auth_state.dart         // 定义认证相关的状态
│── screens // 页面
│   ├── sign_in
│   │   ├── sign_in.dart            // 登录页面的主文件
│   │   ├── cubit                    // 单个页面逻辑
│   │   └── widgets                 // 单个页面组件
│── widgets // 公共组件
│   └── button.dart                 // 公共按钮
│-─ theme // 主题
├── data  // 数据层
│   ├── repositories
│   │   └── <repository_name>       // 数据操作
│   └── models
│       └── <model_name>            // 数据模型
│   └── services
│       └── api                     // 网络请求
├── config
│   └── nav.dart                    // 导航索引常量
├── routing
│   └── app_router.dart             // 应用程序的路由配置
└── utils
    └── validators.dart             // 表单验证的工具函数
```

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
