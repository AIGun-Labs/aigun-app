# AIGun 新功能开发规范

## 目录
- [概述](#概述)
- [架构原则](#架构原则)
- [目录结构规范](#目录结构规范)
- [各层职责说明](#各层职责说明)
- [开发步骤指南](#开发步骤指南)
- [代码规范](#代码规范)
- [依赖注入配置](#依赖注入配置)
- [状态管理规范](#状态管理规范)
- [路由集成](#路由集成)
- [测试指南](#测试指南)
- [与旧架构的区别](#与旧架构的区别)
- [参考示例](#参考示例)

---

## 概述

本文档定义了AIGun项目中新功能开发的标准架构和规范。所有新功能模块必须遵循Clean Architecture原则，采用以下分层结构：

```
lib/features/{feature_name}/
├── domain/         # 业务逻辑层（独立于框架）
├── data/           # 数据访问层
├── presentation/   # UI层
└── utils/          # 功能特定的工具类（可选）
```

**参考模块：** `lib/features/update` 和 `lib/features/ai_agent`

---

## 架构原则

### Clean Architecture 核心理念

1. **依赖规则**：依赖关系只能从外向内指向
   - Presentation → Domain ← Data
   - Domain 层不依赖任何外部框架

2. **关注点分离**：
   - Domain：业务规则、实体、用例
   - Data：数据源、仓储实现、外部服务
   - Presentation：UI、状态管理、用户交互

3. **可测试性**：
   - 所有业务逻辑可独立单元测试
   - 通过抽象接口隔离外部依赖

4. **可维护性**：
   - 单一职责原则
   - 细粒度的Use Cases
   - 明确的状态定义

---

## 目录结构规范

### 完整目录结构示例

```
lib/features/{feature_name}/
│
├── domain/                              # 领域层（核心业务逻辑）
│   ├── entities/                        # 业务实体
│   │   ├── {entity_name}.dart           # Freezed实体类
│   │   ├── {entity_name}.freezed.dart   # 自动生成
│   │   └── {entity_name}.g.dart         # 自动生成（如需JSON序列化）
│   │
│   ├── repositories/                    # 仓储抽象接口
│   │   └── {repository_name}.dart       # abstract class
│   │
│   ├── services/                        # 服务抽象接口
│   │   └── {service_name}.dart          # abstract class
│   │
│   └── usecases/                        # 业务用例（单一职责）
│       ├── {usecase_name_1}.dart        # 用例1
│       ├── {usecase_name_2}.dart        # 用例2
│       └── ...
│
├── data/                                # 数据层（实现）
│   ├── models/                          # 数据模型（DTO）
│   │   ├── {model_name}_dto.dart        # 可选：与Entity不同的DTO
│   │   └── ...
│   │
│   ├── sources/                         # 数据源
│   │   ├── remote/                      # 远程数据源（API）
│   │   │   └── {feature}_remote_source.dart
│   │   └── local/                       # 本地数据源（可选）
│   │       └── {feature}_local_source.dart
│   │
│   ├── repositories/                    # 仓储实现
│   │   └── {repository_name}_impl.dart  # 实现Domain中的Repository接口
│   │
│   └── services/                        # 服务实现
│       └── {service_name}_impl.dart     # 实现Domain中的Service接口
│
├── presentation/                        # 表现层（UI）
│   ├── cubit/                           # 状态管理
│   │   ├── {feature}_cubit.dart         # Cubit类（协调用例）
│   │   ├── {feature}_state.dart         # State定义（Freezed）
│   │   └── {feature}_state.freezed.dart # 自动生成
│   │
│   ├── pages/                           # 页面（可选，小功能可直接用widgets）
│   │   └── {page_name}_page.dart
│   │
│   ├── widgets/                         # UI组件
│   │   ├── {widget_name}_1.dart
│   │   └── {widget_name}_2.dart
│   │
│   └── utils/                           # UI辅助函数（可选）
│       └── show_{feature}_dialog.dart
│
└── utils/                               # 功能特定的工具类（可选）
    └── {util_name}.dart
```

### 目录命名规范

- **功能名称**：使用小写下划线命名，如 `update`, `ai_agent`, `token_swap`
- **文件名称**：使用小写下划线命名，如 `check_for_update.dart`, `update_cubit.dart`
- **类名**：使用大驼峰命名，如 `CheckForUpdate`, `UpdateCubit`

---

## 各层职责说明

### 1. Domain 层（业务逻辑层）

**核心原则**：完全独立于Flutter框架，不导入任何Flutter或第三方UI库。

#### 1.1 Entities（实体）

**职责**：定义核心业务对象

**规范**：
- 使用 Freezed 定义不可变实体
- 如果需要网络传输，添加 `@JsonSerializable` 注解
- 只包含业务属性，不包含UI逻辑

**示例**：
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_info.freezed.dart';
part 'update_info.g.dart';

@freezed
class UpdateInfo with _$UpdateInfo {
  const factory UpdateInfo({
    required String version,
    required int build,
    required String url,
    required String sha256,
    required String filename,
    required List<String> changes,
    @Default(false) bool force,
  }) = _UpdateInfo;

  factory UpdateInfo.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfoFromJson(json);
}
```

#### 1.2 Repositories（仓储接口）

**职责**：定义数据访问契约（抽象接口）

**规范**：
- 只声明方法签名，不包含实现
- 返回 Domain 层的 Entity，而非 Data 层的 DTO
- 方法名应清晰表达业务意图

**示例**：
```dart
abstract class UpdateConfigRepository {
  /// 获取最新版本配置信息
  Future<UpdateInfo?> fetchLatest();
}

abstract class ApkDownloadRepository {
  /// 进度流（0.0 - 1.0）
  Stream<double> get progress$;

  /// 下载APK文件
  Future<String?> download({
    required String url,
    required String filename,
  });

  /// 暂停下载
  Future<void> pause();

  /// 恢复下载
  Future<void> resume();

  /// 取消下载
  Future<void> cancel();
}
```

#### 1.3 Services（服务接口）

**职责**：定义外部平台/系统交互的契约

**规范**：
- 用于隔离平台特定功能（如MethodChannel、原生API）
- 只声明接口，实现在 Data 层

**示例**：
```dart
abstract class ChecksumService {
  /// 计算文件的SHA256校验和
  Future<String> sha256OfFile(String path);
}

abstract class InstallerService {
  /// 检查是否有安装未知来源应用的权限
  Future<bool> canRequestPackageInstalls();

  /// 打开未知来源设置页面
  Future<void> openUnknownSourcesSettings();

  /// 安装APK文件
  Future<void> installApk(String apkPath);
}
```

#### 1.4 Use Cases（业务用例）

**职责**：封装单一业务操作，编排业务规则

**规范**：
- **单一职责**：一个用例只做一件事
- **依赖注入**：通过构造函数注入所需的 Repository/Service
- **命名约定**：使用动词开头，清晰表达业务动作（如 `CheckForUpdate`, `DownloadUpdate`）
- **调用方式**：实现 `call()` 方法，使用例可以像函数一样调用

**示例**：
```dart
class CheckForUpdate {
  final UpdateConfigRepository _repository;

  CheckForUpdate(this._repository);

  /// 检查是否有可用更新
  /// 返回：有更新时返回UpdateInfo，否则返回null
  Future<UpdateInfo?> call() async {
    final latestInfo = await _repository.fetchLatest();
    if (latestInfo == null) return null;

    // 业务逻辑：比较版本号
    final packageInfo = await PackageInfo.fromPlatform();
    final currentBuild = int.tryParse(packageInfo.buildNumber) ?? 0;

    if (currentBuild >= latestInfo.build) {
      return null; // 已是最新版本
    }

    // 语义化版本比较
    final currentVersion = Version.parse(packageInfo.version);
    final latestVersion = Version.parse(latestInfo.version);

    return currentVersion < latestVersion ? latestInfo : null;
  }
}
```

**复杂用例示例**（带进度流）：
```dart
class DownloadUpdate {
  final ApkDownloadRepository _repository;

  DownloadUpdate(this._repository);

  /// 下载进度流
  Stream<double> get progress$ => _repository.progress$;

  /// 开始下载
  Future<String?> call({
    required String url,
    required String filename,
  }) async {
    return await _repository.download(url: url, filename: filename);
  }

  /// 暂停下载
  Future<void> pause() => _repository.pause();

  /// 恢复下载
  Future<void> resume() => _repository.resume();

  /// 取消下载
  Future<void> cancel() => _repository.cancel();
}
```

---

### 2. Data 层（数据访问层）

**核心原则**：实现 Domain 层定义的接口，处理具体的数据获取和存储。

#### 2.1 Data Sources（数据源）

**职责**：从具体来源获取原始数据（API、数据库、缓存等）

**规范**：
- 分为 `remote` 和 `local` 两类
- 使用 Dio 进行网络请求
- 处理原始数据转换为 Entity 或 DTO

**Remote 数据源示例**：
```dart
class LatestConfigDataSource {
  final Dio _dio;
  final EnvConfig _envConfig;

  LatestConfigDataSource(this._dio, this._envConfig);

  String get latestJsonUrl => "${_envConfig.cdn}/apk/aigun/latest.json";

  /// 获取最新版本配置
  Future<UpdateInfo?> fetch() async {
    try {
      final response = await _dio.get(
        latestJsonUrl,
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200) {
        return UpdateInfo.fromJson(response.data);
      }
      return null;
    } catch (e) {
      Logger.error('Failed to fetch latest config: $e');
      rethrow;
    }
  }
}
```

**Local 数据源示例**（可选）：
```dart
class UpdateCacheDataSource {
  final SharedPreferences _prefs;
  static const _key = 'cached_update_info';

  UpdateCacheDataSource(this._prefs);

  Future<UpdateInfo?> get() async {
    final jsonStr = _prefs.getString(_key);
    if (jsonStr == null) return null;

    return UpdateInfo.fromJson(jsonDecode(jsonStr));
  }

  Future<void> save(UpdateInfo info) async {
    await _prefs.setString(_key, jsonEncode(info.toJson()));
  }

  Future<void> clear() async {
    await _prefs.remove(_key);
  }
}
```

#### 2.2 Repositories（仓储实现）

**职责**：实现 Domain 层的 Repository 接口，协调数据源

**规范**：
- 类名以 `Impl` 结尾（如 `UpdateConfigRepositoryImpl`）
- 实现 Domain 层定义的接口
- 协调多个数据源（如先查缓存，再查网络）

**示例**：
```dart
class UpdateConfigRepositoryImpl implements UpdateConfigRepository {
  final LatestConfigDataSource _remoteSource;
  final UpdateCacheDataSource? _localSource; // 可选缓存

  UpdateConfigRepositoryImpl(
    this._remoteSource, [
    this._localSource,
  ]);

  @override
  Future<UpdateInfo?> fetchLatest() async {
    try {
      // 优先从远程获取
      final remote = await _remoteSource.fetch();
      if (remote != null) {
        // 缓存到本地
        await _localSource?.save(remote);
        return remote;
      }

      // 远程失败，尝试本地缓存
      return await _localSource?.get();
    } catch (e) {
      Logger.error('Repository error: $e');
      // 失败时返回缓存
      return await _localSource?.get();
    }
  }
}
```

#### 2.3 Services（服务实现）

**职责**：实现 Domain 层的 Service 接口，处理平台特定功能

**规范**：
- 类名清晰表达实现方式（如 `MethodChannelInstallerService`, `CryptoChecksumService`）
- 处理平台异常并转换为业务异常

**MethodChannel 服务示例**：
```dart
class MethodChannelInstallerService implements InstallerService {
  static const _channel = MethodChannel('app.updater/install');

  @override
  Future<bool> canRequestPackageInstalls() async {
    try {
      final result = await _channel.invokeMethod<bool>('canRequestPackageInstalls');
      return result ?? false;
    } on PlatformException catch (e) {
      Logger.error('Failed to check install permission: ${e.message}');
      return false;
    }
  }

  @override
  Future<void> openUnknownSourcesSettings() async {
    try {
      await _channel.invokeMethod('openUnknownSourcesSettings');
    } on PlatformException catch (e) {
      Logger.error('Failed to open settings: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<void> installApk(String apkPath) async {
    try {
      await _channel.invokeMethod('install', {'path': apkPath});
    } on PlatformException catch (e) {
      if (e.code == 'needs_permission') {
        throw InstallerException('需要安装权限');
      } else if (e.code == 'file_not_found') {
        throw InstallerException('APK文件不存在: $apkPath');
      } else {
        throw InstallerException('安装失败: ${e.message}');
      }
    }
  }
}

// 自定义业务异常
class InstallerException implements Exception {
  final String message;
  InstallerException(this.message);

  @override
  String toString() => message;
}
```

**加密库服务示例**：
```dart
import 'package:crypto/crypto.dart';

class CryptoChecksumService implements ChecksumService {
  @override
  Future<String> sha256OfFile(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      throw ChecksumException('文件不存在: $path');
    }

    try {
      final bytes = await file.readAsBytes();
      final digest = sha256.convert(bytes);
      return digest.toString();
    } catch (e) {
      throw ChecksumException('计算校验和失败: $e');
    }
  }
}

class ChecksumException implements Exception {
  final String message;
  ChecksumException(this.message);

  @override
  String toString() => message;
}
```

---

### 3. Presentation 层（表现层）

**核心原则**：负责UI渲染和用户交互，通过Cubit协调业务用例。

#### 3.1 State（状态定义）

**职责**：使用 Freezed 定义所有可能的 UI 状态

**规范**：
- **细粒度状态**：为每个业务阶段定义独立状态
- **状态完备性**：覆盖所有可能的状态转换
- **携带数据**：每个状态携带必要的业务数据
- **命名约定**：
  - 状态类名：`{Feature}State`
  - 具体状态：`{Feature}{StateDescription}` （如 `UpdateDownloading`, `UpdateAvailable`）

**示例**：
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/update_info.dart';

part 'update_state.freezed.dart';

@freezed
class UpdateState with _$UpdateState {
  // 初始状态
  const factory UpdateState.initial() = UpdateInitial;

  // 检查中
  const factory UpdateState.checking() = UpdateChecking;

  // 无更新
  const factory UpdateState.noUpdate() = UpdateNoUpdate;

  // 有可用更新
  const factory UpdateState.available({
    required UpdateInfo info,
    required bool force,  // 是否强制更新
  }) = UpdateAvailable;

  // 下载中
  const factory UpdateState.downloading({
    required UpdateInfo info,
    required double progress,  // 0.0 - 1.0
  }) = UpdateDownloading;

  // 下载暂停
  const factory UpdateState.paused({
    required UpdateInfo info,
    required double progress,
  }) = UpdatePaused;

  // 验证中
  const factory UpdateState.verifying({
    required UpdateInfo info,
  }) = UpdateVerifying;

  // 下载完成（验证通过）
  const factory UpdateState.downloaded({
    required UpdateInfo info,
    required String path,
  }) = UpdateDownloaded;

  // 校验和验证失败
  const factory UpdateState.checksumFailed({
    required UpdateInfo info,
  }) = UpdateChecksumFailed;

  // 安装中
  const factory UpdateState.installing({
    required String path,
  }) = UpdateInstalling;

  // 需要安装权限
  const factory UpdateState.installNeedsPermission({
    required String path,
  }) = UpdateInstallNeedsPermission;

  // 安装器已启动
  const factory UpdateState.installLaunched() = UpdateInstallLaunched;

  // 取消
  const factory UpdateState.canceled() = UpdateCanceled;

  // 错误
  const factory UpdateState.error({
    required String message,
  }) = UpdateError;
}
```

#### 3.2 Cubit（状态管理）

**职责**：协调多个 Use Case，管理状态转换

**规范**：
- **依赖注入**：通过构造函数注入所有需要的 Use Case
- **单一数据流**：状态只能通过 `emit()` 修改
- **错误处理**：捕获异常并转换为错误状态
- **资源管理**：在 `close()` 中清理 Stream 订阅等资源

**示例**：
```dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/update_info.dart';
import '../../domain/usecases/check_for_update.dart';
import '../../domain/usecases/download_update.dart';
import '../../domain/usecases/verify_checksum.dart';
import '../../domain/usecases/installer_apk.dart';
import '../../domain/usecases/can_install_from_unknown_sources.dart';
import '../../domain/usecases/open_install_settings.dart';
import 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  final CheckForUpdate _checkForUpdate;
  final DownloadUpdate _downloadUpdate;
  final VerifyChecksum _verifyChecksum;
  final InstallerApk _installerApk;
  final CanInstallFromUnknownSources _canInstall;
  final OpenInstallSettings _openSettings;

  StreamSubscription<double>? _progressSubscription;
  UpdateInfo? _currentInfo;

  UpdateCubit(
    this._checkForUpdate,
    this._downloadUpdate,
    this._verifyChecksum,
    this._installerApk,
    this._canInstall,
    this._openSettings,
  ) : super(const UpdateState.initial());

  /// 检查更新
  Future<void> checkForUpdate() async {
    emit(const UpdateState.checking());

    try {
      final updateInfo = await _checkForUpdate();
      _currentInfo = updateInfo;

      if (updateInfo == null) {
        emit(const UpdateState.noUpdate());
      } else {
        emit(UpdateState.available(
          info: updateInfo,
          force: updateInfo.force,
        ));
      }
    } catch (e) {
      emit(UpdateState.error(message: '检查更新失败: $e'));
    }
  }

  /// 开始下载
  Future<void> startDownload() async {
    if (_currentInfo == null) {
      emit(const UpdateState.error(message: '更新信息不存在'));
      return;
    }

    emit(UpdateState.downloading(
      info: _currentInfo!,
      progress: 0.0,
    ));

    // 订阅下载进度
    _progressSubscription = _downloadUpdate.progress$.listen(
      (progress) {
        emit(UpdateState.downloading(
          info: _currentInfo!,
          progress: progress,
        ));
      },
    );

    try {
      final path = await _downloadUpdate(
        url: _currentInfo!.url,
        filename: _currentInfo!.filename,
      );

      await _progressSubscription?.cancel();
      _progressSubscription = null;

      if (path == null) {
        emit(const UpdateState.error(message: '下载失败'));
        return;
      }

      // 下载完成，自动进入验证
      await verifyChecksum(path: path);
    } catch (e) {
      await _progressSubscription?.cancel();
      _progressSubscription = null;
      emit(UpdateState.error(message: '下载失败: $e'));
    }
  }

  /// 验证校验和
  Future<void> verifyChecksum({required String path}) async {
    if (_currentInfo == null) {
      emit(const UpdateState.error(message: '更新信息不存在'));
      return;
    }

    emit(UpdateState.verifying(info: _currentInfo!));

    try {
      final isValid = await _verifyChecksum(path, _currentInfo!.sha256);

      if (!isValid) {
        emit(UpdateState.checksumFailed(info: _currentInfo!));
        return;
      }

      emit(UpdateState.downloaded(
        info: _currentInfo!,
        path: path,
      ));
    } catch (e) {
      emit(UpdateState.error(message: '验证失败: $e'));
    }
  }

  /// 检查并安装
  Future<void> checkAndInstall({required String path}) async {
    final canInstall = await _canInstall();

    if (!canInstall) {
      emit(UpdateState.installNeedsPermission(path: path));
      return;
    }

    await install(path: path);
  }

  /// 安装APK
  Future<void> install({required String path}) async {
    emit(UpdateState.installing(path: path));

    try {
      await _installerApk(path);
      emit(const UpdateState.installLaunched());
    } on InstallerException catch (e) {
      if (e.message.contains('权限')) {
        emit(UpdateState.installNeedsPermission(path: path));
      } else {
        emit(UpdateState.error(message: e.message));
      }
    } catch (e) {
      emit(UpdateState.error(message: '安装失败: $e'));
    }
  }

  /// 打开安装权限设置
  Future<void> openInstallPermissionSettings() async {
    try {
      await _openSettings();
    } catch (e) {
      emit(UpdateState.error(message: '打开设置失败: $e'));
    }
  }

  /// 从设置返回后恢复安装
  Future<void> resumeInstallFromSettings() async {
    final currentState = state;
    if (currentState is UpdateInstallNeedsPermission) {
      await checkAndInstall(path: currentState.path);
    }
  }

  /// 暂停下载
  Future<void> pauseDownload() async {
    try {
      await _downloadUpdate.pause();
      final currentState = state;
      if (currentState is UpdateDownloading) {
        emit(UpdateState.paused(
          info: currentState.info,
          progress: currentState.progress,
        ));
      }
    } catch (e) {
      emit(UpdateState.error(message: '暂停失败: $e'));
    }
  }

  /// 恢复下载
  Future<void> resumeDownload() async {
    try {
      await _downloadUpdate.resume();
      final currentState = state;
      if (currentState is UpdatePaused) {
        emit(UpdateState.downloading(
          info: currentState.info,
          progress: currentState.progress,
        ));
      }
    } catch (e) {
      emit(UpdateState.error(message: '恢复失败: $e'));
    }
  }

  /// 取消下载
  Future<void> cancelDownload() async {
    try {
      await _downloadUpdate.cancel();
      await _progressSubscription?.cancel();
      _progressSubscription = null;
      emit(const UpdateState.canceled());
    } catch (e) {
      emit(UpdateState.error(message: '取消失败: $e'));
    }
  }

  @override
  Future<void> close() async {
    await _progressSubscription?.cancel();
    return super.close();
  }
}
```

#### 3.3 Widgets（UI组件）

**职责**：根据状态渲染UI，响应用户交互

**规范**：
- 使用 `BlocBuilder` 或 `BlocConsumer` 监听状态
- 使用 `state.when()` / `state.whenOrNull()` 进行状态匹配
- 分离复杂UI为独立widget

**页面集成示例**：
```dart
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver {
  StreamSubscription<UpdateState>? _updateSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // 页面加载完成后检查更新
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForUpdate();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // 从后台返回时，恢复安装流程
    if (state == AppLifecycleState.resumed) {
      getIt<UpdateCubit>().resumeInstallFromSettings();
    }
  }

  Future<void> _checkForUpdate() async {
    final updateCubit = getIt<UpdateCubit>();

    _updateSubscription = updateCubit.stream.listen((state) {
      if (!mounted) return;

      state.whenOrNull(
        // 有可用更新 -> 显示更新弹窗
        available: (info, force) {
          showUpdateSheet(
            context,
            info: info,
            force: force,
            onUpdate: () => updateCubit.startDownload(),
          );
        },

        // 下载完成 -> 检查安装权限
        downloaded: (info, path) {
          updateCubit.checkAndInstall(path: path);
        },

        // 需要权限 -> 显示权限对话框
        installNeedsPermission: (path) async {
          await showInstallerDialog(
            context,
            onOpenSettings: () {
              updateCubit.openInstallPermissionSettings();
            },
          );
        },

        // 错误 -> 显示提示
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
      );
    });

    // 启动检查
    await updateCubit.checkForUpdate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _updateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocBuilder<UpdateCubit, UpdateState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            checking: () => const Center(
              child: CircularProgressIndicator(),
            ),
            noUpdate: () => const Center(
              child: Text('已是最新版本'),
            ),
            downloading: (info, progress) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(value: progress),
                  const SizedBox(height: 16),
                  Text('下载中: ${(progress * 100).toStringAsFixed(0)}%'),
                ],
              ),
            ),
            // ... 其他状态
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
```

**对话框/弹窗组件示例**：
```dart
Future<void> showUpdateSheet(
  BuildContext context, {
  required UpdateInfo info,
  required bool force,
  required VoidCallback onUpdate,
}) async {
  return showModalBottomSheet(
    context: context,
    isDismissible: !force,
    enableDrag: !force,
    builder: (context) => UpdateSheet(
      info: info,
      force: force,
      onUpdate: onUpdate,
    ),
  );
}

class UpdateSheet extends StatelessWidget {
  final UpdateInfo info;
  final bool force;
  final VoidCallback onUpdate;

  const UpdateSheet({
    super.key,
    required this.info,
    required this.force,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '发现新版本 v${info.version}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            '更新内容:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...info.changes.map((change) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('• $change'),
              )),
          const SizedBox(height: 24),
          Row(
            children: [
              if (!force)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('稍后更新'),
                  ),
                ),
              if (!force) const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onUpdate();
                  },
                  child: Text(force ? '立即更新' : '现在更新'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

---

## 开发步骤指南

### 完整开发流程（以"交易历史"功能为例）

#### 步骤 1：需求分析与设计

**任务清单**：
- [ ] 明确功能需求（如：查看交易历史、按类型筛选、导出CSV）
- [ ] 确定需要的实体（如：`TradeHistoryItem`）
- [ ] 识别数据来源（API、本地数据库）
- [ ] 定义用例（如：`FetchTradeHistory`, `FilterByType`, `ExportToCsv`）
- [ ] 设计状态（如：`loading`, `loaded`, `empty`, `error`）

#### 步骤 2：创建目录结构

```bash
mkdir -p lib/features/trade_history/{domain/{entities,repositories,usecases},data/{sources/remote,repositories},presentation/{cubit,pages,widgets}}
```

#### 步骤 3：编写 Domain 层

**3.1 定义实体**：

创建 `lib/features/trade_history/domain/entities/trade_history_item.dart`：

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_history_item.freezed.dart';
part 'trade_history_item.g.dart';

@freezed
class TradeHistoryItem with _$TradeHistoryItem {
  const factory TradeHistoryItem({
    required String id,
    required String tokenAddress,
    required String tokenSymbol,
    required TradeType type,
    required double amount,
    required double price,
    required DateTime timestamp,
  }) = _TradeHistoryItem;

  factory TradeHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$TradeHistoryItemFromJson(json);
}

enum TradeType { buy, sell }
```

**3.2 定义仓储接口**：

创建 `lib/features/trade_history/domain/repositories/trade_history_repository.dart`：

```dart
import '../entities/trade_history_item.dart';

abstract class TradeHistoryRepository {
  Future<List<TradeHistoryItem>> fetchHistory({
    int page = 1,
    int pageSize = 20,
    TradeType? type,
  });
}
```

**3.3 定义用例**：

创建 `lib/features/trade_history/domain/usecases/fetch_trade_history.dart`：

```dart
import '../entities/trade_history_item.dart';
import '../repositories/trade_history_repository.dart';

class FetchTradeHistory {
  final TradeHistoryRepository _repository;

  FetchTradeHistory(this._repository);

  Future<List<TradeHistoryItem>> call({
    int page = 1,
    int pageSize = 20,
    TradeType? type,
  }) async {
    return await _repository.fetchHistory(
      page: page,
      pageSize: pageSize,
      type: type,
    );
  }
}
```

**运行代码生成**：

```bash
dart run build_runner build --delete-conflicting-outputs
```

#### 步骤 4：编写 Data 层

**4.1 创建远程数据源**：

创建 `lib/features/trade_history/data/sources/remote/trade_history_remote_source.dart`：

```dart
import 'package:dio/dio.dart';
import '../../../domain/entities/trade_history_item.dart';

class TradeHistoryRemoteSource {
  final Dio _dio;

  TradeHistoryRemoteSource(this._dio);

  Future<List<TradeHistoryItem>> fetchHistory({
    required int page,
    required int pageSize,
    TradeType? type,
  }) async {
    try {
      final response = await _dio.get(
        '/api/trade/history',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
          if (type != null) 'type': type.name,
        },
      );

      final List<dynamic> data = response.data['items'];
      return data.map((json) => TradeHistoryItem.fromJson(json)).toList();
    } catch (e) {
      throw TradeHistoryException('获取交易历史失败: $e');
    }
  }
}

class TradeHistoryException implements Exception {
  final String message;
  TradeHistoryException(this.message);

  @override
  String toString() => message;
}
```

**4.2 实现仓储**：

创建 `lib/features/trade_history/data/repositories/trade_history_repository_impl.dart`：

```dart
import '../../domain/entities/trade_history_item.dart';
import '../../domain/repositories/trade_history_repository.dart';
import '../sources/remote/trade_history_remote_source.dart';

class TradeHistoryRepositoryImpl implements TradeHistoryRepository {
  final TradeHistoryRemoteSource _remoteSource;

  TradeHistoryRepositoryImpl(this._remoteSource);

  @override
  Future<List<TradeHistoryItem>> fetchHistory({
    int page = 1,
    int pageSize = 20,
    TradeType? type,
  }) async {
    return await _remoteSource.fetchHistory(
      page: page,
      pageSize: pageSize,
      type: type,
    );
  }
}
```

#### 步骤 5：编写 Presentation 层

**5.1 定义状态**：

创建 `lib/features/trade_history/presentation/cubit/trade_history_state.dart`：

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/trade_history_item.dart';

part 'trade_history_state.freezed.dart';

@freezed
class TradeHistoryState with _$TradeHistoryState {
  const factory TradeHistoryState.initial() = TradeHistoryInitial;

  const factory TradeHistoryState.loading() = TradeHistoryLoading;

  const factory TradeHistoryState.loaded({
    required List<TradeHistoryItem> items,
    required int page,
    required bool hasMore,
  }) = TradeHistoryLoaded;

  const factory TradeHistoryState.empty() = TradeHistoryEmpty;

  const factory TradeHistoryState.error({
    required String message,
  }) = TradeHistoryError;
}
```

**5.2 创建 Cubit**：

创建 `lib/features/trade_history/presentation/cubit/trade_history_cubit.dart`：

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/trade_history_item.dart';
import '../../domain/usecases/fetch_trade_history.dart';
import 'trade_history_state.dart';

class TradeHistoryCubit extends Cubit<TradeHistoryState> {
  final FetchTradeHistory _fetchTradeHistory;

  static const _pageSize = 20;
  int _currentPage = 1;
  TradeType? _currentFilter;

  TradeHistoryCubit(this._fetchTradeHistory)
      : super(const TradeHistoryState.initial());

  /// 加载初始数据
  Future<void> loadInitial({TradeType? filter}) async {
    emit(const TradeHistoryState.loading());
    _currentPage = 1;
    _currentFilter = filter;

    try {
      final items = await _fetchTradeHistory(
        page: _currentPage,
        pageSize: _pageSize,
        type: filter,
      );

      if (items.isEmpty) {
        emit(const TradeHistoryState.empty());
      } else {
        emit(TradeHistoryState.loaded(
          items: items,
          page: _currentPage,
          hasMore: items.length >= _pageSize,
        ));
      }
    } catch (e) {
      emit(TradeHistoryState.error(message: e.toString()));
    }
  }

  /// 加载更多
  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! TradeHistoryLoaded) return;
    if (!currentState.hasMore) return;

    _currentPage++;

    try {
      final newItems = await _fetchTradeHistory(
        page: _currentPage,
        pageSize: _pageSize,
        type: _currentFilter,
      );

      emit(TradeHistoryState.loaded(
        items: [...currentState.items, ...newItems],
        page: _currentPage,
        hasMore: newItems.length >= _pageSize,
      ));
    } catch (e) {
      _currentPage--; // 回退页码
      emit(TradeHistoryState.error(message: e.toString()));
    }
  }

  /// 刷新
  Future<void> refresh() => loadInitial(filter: _currentFilter);
}
```

**运行代码生成**：

```bash
dart run build_runner build --delete-conflicting-outputs
```

**5.3 创建页面**：

创建 `lib/features/trade_history/presentation/pages/trade_history_page.dart`：

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service_locator.dart';
import '../cubit/trade_history_cubit.dart';
import '../cubit/trade_history_state.dart';
import '../widgets/trade_history_item_widget.dart';

class TradeHistoryPage extends StatelessWidget {
  const TradeHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TradeHistoryCubit>()..loadInitial(),
      child: const _TradeHistoryView(),
    );
  }
}

class _TradeHistoryView extends StatelessWidget {
  const _TradeHistoryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('交易历史'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<TradeHistoryCubit, TradeHistoryState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (items, page, hasMore) => RefreshIndicator(
              onRefresh: () => context.read<TradeHistoryCubit>().refresh(),
              child: ListView.builder(
                itemCount: items.length + (hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < items.length) {
                    return TradeHistoryItemWidget(item: items[index]);
                  } else {
                    // 加载更多指示器
                    context.read<TradeHistoryCubit>().loadMore();
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
            empty: () => const Center(
              child: Text('暂无交易记录'),
            ),
            error: (message) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('加载失败: $message'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<TradeHistoryCubit>().refresh(),
                    child: const Text('重试'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    // 筛选对话框实现
  }
}
```

#### 步骤 6：配置依赖注入

创建 `lib/core/di/modules/trade_history_module.dart`：

```dart
import 'package:get_it/get_it.dart';
import '../../../features/trade_history/data/repositories/trade_history_repository_impl.dart';
import '../../../features/trade_history/data/sources/remote/trade_history_remote_source.dart';
import '../../../features/trade_history/domain/repositories/trade_history_repository.dart';
import '../../../features/trade_history/domain/usecases/fetch_trade_history.dart';
import '../../../features/trade_history/presentation/cubit/trade_history_cubit.dart';

class TradeHistoryModule {
  final GetIt _sl;

  TradeHistoryModule(this._sl);

  Future<void> init() async {
    // 数据源
    _sl.registerLazySingleton<TradeHistoryRemoteSource>(
      () => TradeHistoryRemoteSource(_sl()),
    );

    // 仓储
    _sl.registerLazySingleton<TradeHistoryRepository>(
      () => TradeHistoryRepositoryImpl(_sl()),
    );

    // 用例
    _sl.registerLazySingleton(
      () => FetchTradeHistory(_sl()),
    );

    // Cubit (Factory - 每次创建新实例)
    _sl.registerFactory(
      () => TradeHistoryCubit(_sl()),
    );
  }
}
```

在 `lib/core/service_locator.dart` 中注册：

```dart
Future<void> setupServiceLocator() async {
  // ... 其他模块

  await TradeHistoryModule(getIt).init();
}
```

#### 步骤 7：添加路由

在 `lib/routing/app_router.dart` 中添加路由：

```dart
GoRoute(
  path: RoutesPath.tradeHistory,
  name: RoutesPath.tradeHistory,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: const TradeHistoryPage(),
    transitionsBuilder: rightToLeft,
  ),
),
```

在 `lib/routing/routes_path.dart` 中添加路径：

```dart
static const tradeHistory = '/trade-history';
```

#### 步骤 8：测试

**8.1 单元测试（Use Case）**：

创建 `test/features/trade_history/domain/usecases/fetch_trade_history_test.dart`：

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:aigun/features/trade_history/domain/entities/trade_history_item.dart';
import 'package:aigun/features/trade_history/domain/repositories/trade_history_repository.dart';
import 'package:aigun/features/trade_history/domain/usecases/fetch_trade_history.dart';

@GenerateMocks([TradeHistoryRepository])
import 'fetch_trade_history_test.mocks.dart';

void main() {
  late FetchTradeHistory usecase;
  late MockTradeHistoryRepository mockRepository;

  setUp(() {
    mockRepository = MockTradeHistoryRepository();
    usecase = FetchTradeHistory(mockRepository);
  });

  test('should return trade history from repository', () async {
    // Arrange
    final tItems = [
      TradeHistoryItem(
        id: '1',
        tokenAddress: '0x123',
        tokenSymbol: 'ETH',
        type: TradeType.buy,
        amount: 1.0,
        price: 2000.0,
        timestamp: DateTime.now(),
      ),
    ];

    when(mockRepository.fetchHistory(
      page: 1,
      pageSize: 20,
      type: null,
    )).thenAnswer((_) async => tItems);

    // Act
    final result = await usecase(page: 1, pageSize: 20);

    // Assert
    expect(result, tItems);
    verify(mockRepository.fetchHistory(page: 1, pageSize: 20, type: null));
    verifyNoMoreInteractions(mockRepository);
  });
}
```

**8.2 Cubit 测试**：

创建 `test/features/trade_history/presentation/cubit/trade_history_cubit_test.dart`：

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:aigun/features/trade_history/domain/entities/trade_history_item.dart';
import 'package:aigun/features/trade_history/domain/usecases/fetch_trade_history.dart';
import 'package:aigun/features/trade_history/presentation/cubit/trade_history_cubit.dart';
import 'package:aigun/features/trade_history/presentation/cubit/trade_history_state.dart';

@GenerateMocks([FetchTradeHistory])
import 'trade_history_cubit_test.mocks.dart';

void main() {
  late TradeHistoryCubit cubit;
  late MockFetchTradeHistory mockFetchTradeHistory;

  setUp(() {
    mockFetchTradeHistory = MockFetchTradeHistory();
    cubit = TradeHistoryCubit(mockFetchTradeHistory);
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be TradeHistoryInitial', () {
    expect(cubit.state, const TradeHistoryState.initial());
  });

  blocTest<TradeHistoryCubit, TradeHistoryState>(
    'emits [loading, loaded] when loadInitial succeeds',
    build: () {
      final tItems = [
        TradeHistoryItem(
          id: '1',
          tokenAddress: '0x123',
          tokenSymbol: 'ETH',
          type: TradeType.buy,
          amount: 1.0,
          price: 2000.0,
          timestamp: DateTime.now(),
        ),
      ];

      when(mockFetchTradeHistory(
        page: anyNamed('page'),
        pageSize: anyNamed('pageSize'),
        type: anyNamed('type'),
      )).thenAnswer((_) async => tItems);

      return cubit;
    },
    act: (cubit) => cubit.loadInitial(),
    expect: () => [
      const TradeHistoryState.loading(),
      isA<TradeHistoryLoaded>()
        .having((s) => s.items.length, 'items length', 1)
        .having((s) => s.page, 'page', 1),
    ],
    verify: (_) {
      verify(mockFetchTradeHistory(page: 1, pageSize: 20, type: null)).called(1);
    },
  );

  blocTest<TradeHistoryCubit, TradeHistoryState>(
    'emits [loading, error] when loadInitial fails',
    build: () {
      when(mockFetchTradeHistory(
        page: anyNamed('page'),
        pageSize: anyNamed('pageSize'),
        type: anyNamed('type'),
      )).thenThrow(Exception('Network error'));

      return cubit;
    },
    act: (cubit) => cubit.loadInitial(),
    expect: () => [
      const TradeHistoryState.loading(),
      isA<TradeHistoryError>()
        .having((s) => s.message, 'message', contains('Network error')),
    ],
  );
}
```

---

## 代码规范

### 命名规范

| 类型 | 规范 | 示例 |
|------|------|------|
| 功能目录 | 小写下划线 | `trade_history`, `ai_agent` |
| 文件名 | 小写下划线 | `fetch_trade_history.dart` |
| 类名 | 大驼峰 | `FetchTradeHistory`, `UpdateCubit` |
| 变量/方法 | 小驼峰 | `fetchHistory`, `currentPage` |
| 常量 | 小写下划线 | `_page_size`, `max_retries` |
| 枚举值 | 小驼峰 | `TradeType.buy`, `Status.loading` |

### 代码组织

#### 导入顺序

```dart
// 1. Dart核心库
import 'dart:async';
import 'dart:io';

// 2. Flutter框架
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 3. 第三方包（按字母排序）
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 4. 项目内部导入（相对路径，按字母排序）
import '../../domain/entities/update_info.dart';
import '../../domain/usecases/check_for_update.dart';
import '../cubit/update_state.dart';

// 5. Part文件（最后）
part 'update_cubit.freezed.dart';
```

#### 类成员顺序

```dart
class ExampleClass {
  // 1. 静态常量
  static const maxRetries = 3;

  // 2. 静态变量
  static int instanceCount = 0;

  // 3. 私有实例变量
  final Dio _dio;
  final Repository _repo;

  // 4. 公共实例变量
  final String name;

  // 5. 构造函数
  ExampleClass(this._dio, this._repo, this.name) {
    instanceCount++;
  }

  // 6. 命名构造函数
  ExampleClass.withDefaults() : this(Dio(), RepositoryImpl(), 'default');

  // 7. Getter/Setter
  String get displayName => name.toUpperCase();

  // 8. 公共方法
  Future<void> fetchData() async { ... }

  // 9. 私有方法
  void _processData() { ... }

  // 10. Override方法
  @override
  String toString() => 'ExampleClass($name)';
}
```

### 注释规范

```dart
/// 检查是否有可用更新
///
/// 比较当前版本与远程最新版本，判断是否需要更新。
///
/// 返回：
/// - 有更新时返回 [UpdateInfo]
/// - 已是最新版本或检查失败时返回 null
///
/// 抛出：
/// - [NetworkException] 网络请求失败
class CheckForUpdate {
  final UpdateConfigRepository _repository;

  CheckForUpdate(this._repository);

  Future<UpdateInfo?> call() async {
    // 业务逻辑实现...
  }
}
```

### 错误处理

```dart
// ✅ 推荐：定义业务异常
class UpdateException implements Exception {
  final String message;
  final String? code;

  UpdateException(this.message, {this.code});

  @override
  String toString() => code != null ? '[$code] $message' : message;
}

// ✅ 推荐：在Service层转换平台异常
class MethodChannelInstallerService implements InstallerService {
  @override
  Future<void> installApk(String path) async {
    try {
      await _channel.invokeMethod('install', {'path': path});
    } on PlatformException catch (e) {
      // 转换为业务异常
      if (e.code == 'needs_permission') {
        throw UpdateException('需要安装权限', code: 'PERMISSION_DENIED');
      }
      throw UpdateException('安装失败: ${e.message}', code: e.code);
    }
  }
}

// ✅ 推荐：在Cubit层捕获并转为状态
class UpdateCubit extends Cubit<UpdateState> {
  Future<void> install({required String path}) async {
    try {
      await _installerApk(path);
      emit(const UpdateState.installLaunched());
    } on UpdateException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        emit(UpdateState.installNeedsPermission(path: path));
      } else {
        emit(UpdateState.error(message: e.message));
      }
    } catch (e) {
      emit(UpdateState.error(message: '未知错误: $e'));
    }
  }
}
```

---

## 依赖注入配置

### Module 模式

每个功能模块独立管理自己的依赖注入：

```dart
import 'package:get_it/get_it.dart';

abstract class InjectionModule {
  Future<void> init();
}

class UpdateModule implements InjectionModule {
  final GetIt _sl;

  UpdateModule(this._sl);

  @override
  Future<void> init() async {
    // 第1层：数据源
    _sl.registerLazySingleton<LatestConfigDataSource>(
      () => LatestConfigDataSource(_sl()),
    );

    // 第2层：仓储和服务实现
    _sl.registerLazySingleton<UpdateConfigRepository>(
      () => UpdateConfigRepositoryImpl(_sl()),
    );
    _sl.registerLazySingleton<ApkDownloadRepository>(
      () => ApkDownloadRepositoryImpl(),
    );
    _sl.registerLazySingleton<ChecksumService>(
      () => CryptoChecksumService(),
    );
    _sl.registerLazySingleton<InstallerService>(
      () => MethodChannelInstallerService(),
    );

    // 第3层：业务用例
    _sl.registerLazySingleton(() => CheckForUpdate(_sl()));
    _sl.registerLazySingleton(() => DownloadUpdate(_sl()));
    _sl.registerLazySingleton(() => VerifyChecksum(_sl()));
    _sl.registerLazySingleton(() => InstallerApk(_sl()));
    _sl.registerLazySingleton(() => CanInstallFromUnknownSources(_sl()));
    _sl.registerLazySingleton(() => OpenInstallSettings(_sl()));

    // 第4层：Cubit
    _sl.registerLazySingleton(() => UpdateCubit(
          _sl(),
          _sl(),
          _sl(),
          _sl(),
          _sl(),
          _sl(),
        ));
  }
}
```

### 注册策略

| 注册方式 | 使用场景 | 示例 |
|---------|---------|------|
| `registerLazySingleton` | 全局单例，延迟初始化 | DataSource, Repository, Service, UseCase, 全局Cubit |
| `registerFactory` | 每次创建新实例 | 页面级Cubit, ViewModel |
| `registerSingleton` | 全局单例，立即初始化 | SharedPreferences, Dio配置 |

### 全局Provider配置

在 `lib/widgets/global_provide.dart` 中注册全局Cubit：

```dart
class GlobalProvide extends StatelessWidget {
  final Widget child;

  const GlobalProvide({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // 旧架构的全局Cubit
        BlocProvider(create: (context) => getIt<UserCubit>()),
        BlocProvider(create: (context) => getIt<WalletCubit>()),

        // 新架构的功能Cubit
        BlocProvider(create: (context) => getIt<UpdateCubit>()),
        BlocProvider(create: (context) => getIt<AiAgentCubit>()),

        // ... 其他全局Cubit
      ],
      child: child,
    );
  }
}
```

---

## 状态管理规范

### 状态设计原则

1. **细粒度状态**：为每个业务阶段定义独立状态
2. **完备性**：覆盖所有可能的状态转换
3. **不变性**：使用 Freezed 保证状态不可变
4. **数据携带**：每个状态携带必要的业务数据

### 常见状态模式

#### 模式 1：简单加载-成功-失败

```dart
@freezed
class SimpleState with _$SimpleState {
  const factory SimpleState.initial() = SimpleInitial;
  const factory SimpleState.loading() = SimpleLoading;
  const factory SimpleState.success({required Data data}) = SimpleSuccess;
  const factory SimpleState.error({required String message}) = SimpleError;
}
```

#### 模式 2：分页列表

```dart
@freezed
class PaginatedState with _$PaginatedState {
  const factory PaginatedState.initial() = PaginatedInitial;
  const factory PaginatedState.loading() = PaginatedLoading;

  const factory PaginatedState.loaded({
    required List<Item> items,
    required int page,
    required bool hasMore,
  }) = PaginatedLoaded;

  const factory PaginatedState.loadingMore({
    required List<Item> items,
    required int page,
  }) = PaginatedLoadingMore;

  const factory PaginatedState.empty() = PaginatedEmpty;
  const factory PaginatedState.error({required String message}) = PaginatedError;
}
```

#### 模式 3：多步骤流程（如Update）

```dart
@freezed
class MultiStepState with _$MultiStepState {
  // 初始和准备阶段
  const factory MultiStepState.initial() = MultiStepInitial;
  const factory MultiStepState.preparing() = MultiStepPreparing;

  // 步骤1
  const factory MultiStepState.step1InProgress({required Data data}) = Step1InProgress;
  const factory MultiStepState.step1Completed({required Data data}) = Step1Completed;

  // 步骤2
  const factory MultiStepState.step2InProgress({
    required Data data,
    required double progress,
  }) = Step2InProgress;
  const factory MultiStepState.step2Paused({
    required Data data,
    required double progress,
  }) = Step2Paused;
  const factory MultiStepState.step2Completed({required Data data}) = Step2Completed;

  // 终止状态
  const factory MultiStepState.completed() = MultiStepCompleted;
  const factory MultiStepState.canceled() = MultiStepCanceled;
  const factory MultiStepState.error({required String message}) = MultiStepError;
}
```

### 状态监听模式

#### 在Widget中使用 BlocBuilder

```dart
BlocBuilder<UpdateCubit, UpdateState>(
  builder: (context, state) {
    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const CircularProgressIndicator(),
      success: (data) => Text('Success: $data'),
      error: (msg) => Text('Error: $msg'),
    );
  },
)
```

#### 在Widget中使用 BlocConsumer（需要副作用）

```dart
BlocConsumer<UpdateCubit, UpdateState>(
  listener: (context, state) {
    // 副作用：显示Toast、导航等
    state.whenOrNull(
      error: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
      completed: () {
        Navigator.of(context).pop();
      },
    );
  },
  builder: (context, state) {
    // UI渲染
    return state.when(
      // ...
    );
  },
)
```

#### 在State中监听Stream（复杂流程）

```dart
class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<UpdateState>? _subscription;

  @override
  void initState() {
    super.initState();

    final cubit = getIt<UpdateCubit>();
    _subscription = cubit.stream.listen((state) {
      if (!mounted) return;

      state.whenOrNull(
        available: (info, force) => _showUpdateSheet(info, force),
        downloaded: (info, path) => cubit.checkAndInstall(path: path),
      );
    });

    cubit.checkForUpdate();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
```

---

## 路由集成

### 添加路由配置

1. **定义路径常量**（`lib/routing/routes_path.dart`）：

```dart
class RoutesPath {
  // ... 现有路由

  static const tradeHistory = '/trade-history';
  static const aiChat = '/ai-chat';
}
```

2. **注册路由**（`lib/routing/app_router.dart`）：

```dart
final appRouter = GoRouter(
  initialLocation: RoutesPath.splash,
  routes: [
    // ... 现有路由

    // 新功能路由
    GoRoute(
      path: RoutesPath.tradeHistory,
      name: RoutesPath.tradeHistory,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const TradeHistoryPage(),
        transitionsBuilder: rightToLeft, // 右进左出动画
      ),
    ),

    // 带参数的路由
    GoRoute(
      path: '${RoutesPath.tokenDetail}/:address',
      name: RoutesPath.tokenDetail,
      pageBuilder: (context, state) {
        final address = state.pathParameters['address']!;
        return CustomTransitionPage(
          child: TokenDetailPage(tokenAddress: address),
          transitionsBuilder: bottomToTop, // 底部弹出动画
        );
      },
    ),
  ],
);
```

### 路由导航

```dart
// 简单导航
context.go(RoutesPath.tradeHistory);

// 带参数导航
context.go('${RoutesPath.tokenDetail}/0x123abc');

// Push导航（可返回）
context.push(RoutesPath.tradeHistory);

// 替换当前路由
context.replace(RoutesPath.home);

// 返回
context.pop();

// 返回并传递结果
context.pop(result);
```

---

## 测试指南

### 测试结构

```
test/
└── features/
    └── {feature_name}/
        ├── domain/
        │   ├── usecases/
        │   │   └── {usecase}_test.dart
        │   └── entities/
        │       └── {entity}_test.dart
        ├── data/
        │   ├── repositories/
        │   │   └── {repository}_impl_test.dart
        │   └── sources/
        │       └── {source}_test.dart
        └── presentation/
            └── cubit/
                └── {cubit}_test.dart
```

### 依赖

在 `pubspec.yaml` 中添加：

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.0
  bloc_test: ^9.1.0
  build_runner: ^2.4.0
```

### Use Case 测试模板

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([YourRepository])
import 'your_usecase_test.mocks.dart';

void main() {
  late YourUseCase usecase;
  late MockYourRepository mockRepository;

  setUp(() {
    mockRepository = MockYourRepository();
    usecase = YourUseCase(mockRepository);
  });

  group('YourUseCase', () {
    test('should return data from repository when call is successful', () async {
      // Arrange
      final tData = YourEntity(/* ... */);
      when(mockRepository.fetchData()).thenAnswer((_) async => tData);

      // Act
      final result = await usecase();

      // Assert
      expect(result, tData);
      verify(mockRepository.fetchData());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.fetchData()).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(() => usecase(), throwsException);
    });
  });
}
```

### Cubit 测试模板

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([YourUseCase])
import 'your_cubit_test.mocks.dart';

void main() {
  late YourCubit cubit;
  late MockYourUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockYourUseCase();
    cubit = YourCubit(mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state is correct', () {
    expect(cubit.state, const YourState.initial());
  });

  blocTest<YourCubit, YourState>(
    'emits [loading, success] when action succeeds',
    build: () {
      when(mockUseCase()).thenAnswer((_) async => yourData);
      return cubit;
    },
    act: (cubit) => cubit.performAction(),
    expect: () => [
      const YourState.loading(),
      YourState.success(data: yourData),
    ],
    verify: (_) {
      verify(mockUseCase()).called(1);
    },
  );

  blocTest<YourCubit, YourState>(
    'emits [loading, error] when action fails',
    build: () {
      when(mockUseCase()).thenThrow(Exception('Error'));
      return cubit;
    },
    act: (cubit) => cubit.performAction(),
    expect: () => [
      const YourState.loading(),
      isA<YourError>().having((s) => s.message, 'message', contains('Error')),
    ],
  );
}
```

---

## 与旧架构的区别

| 方面 | 旧架构（`lib/cubits`, `lib/screens`） | 新架构（`lib/features`） |
|------|-----------------------------------|----------------------|
| **目录组织** | 按技术分层（cubits/, screens/, data/） | 按功能模块（features/{feature}/） |
| **业务逻辑位置** | Cubit中混杂业务逻辑 | 独立的Use Case |
| **依赖方式** | Cubit内部直接getIt获取依赖 | 构造函数注入，依赖清晰 |
| **状态定义** | 简单的status枚举或copyWith | Freezed细粒度状态 |
| **测试性** | 难以单元测试业务逻辑 | 每个Use Case可独立测试 |
| **可维护性** | 功能分散，难以定位 | 功能内聚，易于维护 |
| **可扩展性** | 添加功能需修改多处 | 模块化，互不影响 |
| **关注点分离** | 混合 | 清晰分离（Domain/Data/Presentation） |

### 迁移建议

**新功能**：一律使用新架构

**旧功能**：
- **不紧急**：保持现状，逐步重构
- **需要大改**：趁机重构为新架构
- **频繁维护**：优先重构为新架构

---

## 参考示例

### 完整参考模块

1. **Update模块** (`lib/features/update`)
   - 完整的多步骤流程
   - 进度流处理
   - MethodChannel集成
   - 权限处理流程

2. **AI Agent模块** (`lib/features/ai_agent`)
   - 复杂业务逻辑
   - WebSocket集成
   - 流式数据处理

### 学习路径

1. **阅读Update模块源码**：理解完整流程
2. **编写简单功能**：如"收藏列表"，练习分层
3. **编写复杂功能**：如"K线图"，练习状态机
4. **重构旧功能**：如"交易历史"，对比新旧架构

---

## 常见问题

### Q1: 什么时候使用 Entity 和 DTO？

**A**:
- **Entity**：Domain层的业务对象，代表核心业务概念
- **DTO (Data Transfer Object)**：Data层的数据传输对象，用于网络/数据库

**何时需要DTO**：
- API返回的数据结构与业务实体不同
- 需要在Repository层进行数据转换

**示例**：
```dart
// API返回的DTO
class UserDTO {
  final String userName;
  final String emailAddr;

  UserDTO.fromJson(Map<String, dynamic> json)
    : userName = json['user_name'],
      emailAddr = json['email_addr'];
}

// 领域实体
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromDTO(UserDTO dto) => User(
    name: dto.userName,
    email: dto.emailAddr,
  );
}
```

### Q2: Cubit 应该注册为 Singleton 还是 Factory？

**A**:
- **Singleton** (`registerLazySingleton`)：全局共享状态的Cubit（如UserCubit, WalletCubit, UpdateCubit）
- **Factory** (`registerFactory`)：页面级Cubit，每次创建新实例（如TradeHistoryCubit, TokenDetailCubit）

### Q3: 如何处理需要多个Repository的UseCase？

**A**: 直接在构造函数中注入多个Repository：

```dart
class SyncDataUseCase {
  final LocalRepository _local;
  final RemoteRepository _remote;

  SyncDataUseCase(this._local, this._remote);

  Future<void> call() async {
    final remoteData = await _remote.fetch();
    await _local.save(remoteData);
  }
}
```

### Q4: 如何在Use Case中使用其他Use Case？

**A**: 通过依赖注入：

```dart
class ComplexUseCase {
  final FetchDataUseCase _fetchData;
  final ProcessDataUseCase _processData;

  ComplexUseCase(this._fetchData, this._processData);

  Future<Result> call() async {
    final data = await _fetchData();
    return await _processData(data);
  }
}
```

### Q5: 如何处理需要Context的情况（如显示Toast）？

**A**:
- **Domain/Data层**：绝不使用Context，通过状态或异常返回结果
- **Presentation层**：在Widget中监听状态，执行UI操作

```dart
// ❌ 错误：在UseCase中使用Context
class ShowToastUseCase {
  void call(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(/*...*/);
  }
}

// ✅ 正确：在Widget中监听状态
BlocListener<YourCubit, YourState>(
  listener: (context, state) {
    state.whenOrNull(
      error: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
    );
  },
  child: /*...*/,
)
```

---

## 附录

### 常用命令速查

```bash
# 代码生成（Freezed/JSON）
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch  # 监听模式

# 本地化
flutter gen-l10n

# 代码分析
flutter analyze

# 运行测试
flutter test
flutter test test/features/update/  # 运行特定模块测试

# 运行应用
flutter run
flutter run --dart-define=ENV=development1
```

### 推荐VSCode插件

- **Flutter**: Flutter官方插件
- **Bloc**: Bloc/Cubit代码片段
- **Freezed**: Freezed代码片段
- **Flutter Intl**: 本地化管理
- **Error Lens**: 实时显示错误

### 推荐阅读

- [Clean Architecture (Robert C. Martin)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Bloc State Management](https://bloclibrary.dev/)
- [Freezed Documentation](https://pub.dev/packages/freezed)
- [GoRouter Documentation](https://pub.dev/packages/go_router)

---

## 总结

新架构的核心优势：

1. **清晰分层**：Domain/Data/Presentation职责明确
2. **业务内聚**：相关代码组织在同一功能目录
3. **可测试性**：Use Case可独立单元测试
4. **可维护性**：细粒度状态+单一职责用例
5. **可扩展性**：模块化设计，互不影响

**开发新功能时，请严格遵循本规范！**
