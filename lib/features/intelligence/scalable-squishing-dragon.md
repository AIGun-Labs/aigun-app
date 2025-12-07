# Intel 模块迁移至 Clean Architecture 计划

## 目标
将 `lib/screens/intel/` 和 `lib/cubits/intel/` 迁移到 `lib/features/intel/`，遵循 Clean Architecture + DDD 设计原则。

---

## 一、现有模块分析

### 1.1 当前文件结构
```
lib/screens/intel/
├── intel.dart                          # 主屏幕 (TabController, 两个Tab)
└── widgets/                            # 33个Widget文件
    ├── intel_list.dart                 # 分页列表
    ├── event_handler_intel_list.dart   # 事件类型列表
    ├── signal_intel_list.dart.dart     # 雷达信号列表
    ├── intelligence_type/              # 类型分类器
    │   ├── base.dart, new.dart, signal.dart, twitter.dart
    ├── intel_item/                     # 情报项组件
    │   ├── intel_header.dart, intel_message.dart, intel_markdown.dart
    ├── unread_bar.dart                 # 未读通知栏
    └── ...

lib/cubits/intel/
├── intel_cubit.dart                    # 主Cubit (WebSocket, 轮询, API)
└── intel_state.dart                    # 状态定义

lib/data/models/intel/
├── intel.dart                          # Freezed模型 (Intel, Entity, AIAgent等)
├── intel.freezed.dart
└── intel.g.dart

lib/data/services/api/intel_api.dart    # API服务
```

### 1.2 核心业务逻辑
1. **双Tab系统**：推荐(event) + 链上信号(radar_signal)
2. **WebSocket实时更新**：接收新情报
3. **Token轮询**：定期更新Token价格
4. **未读管理**：跟踪/显示未读情报
5. **分页加载**：历史记录拉取

### 1.3 依赖关系
- `IntelApi` - HTTP API
- `WebSocketService` - 实时通信
- `PollingService` - Token更新轮询
- `OptionsCubit` - 链过滤选项

---

## 二、目标架构

```
lib/features/intel/
├── domain/                             # 领域层 (纯Dart)
│   ├── entities/                       # 业务实体
│   │   ├── intel_entity.dart
│   │   ├── token_entity.dart
│   │   ├── ai_agent_entity.dart
│   │   ├── author_entity.dart
│   │   └── media_entity.dart
│   ├── repositories/                   # 仓库接口
│   │   └── intel_repository.dart
│   ├── usecases/                       # 用例
│   │   ├── fetch_event_intelligence.dart
│   │   ├── fetch_signal_intelligence.dart
│   │   ├── fetch_intel_tokens.dart
│   │   ├── subscribe_realtime_intel.dart
│   │   └── manage_unread_intel.dart
│   └── value_objects/                  # 值对象
│       └── intel_type.dart
│
├── data/                               # 数据层
│   ├── models/                         # DTO模型
│   │   ├── intel_model.dart
│   │   ├── token_model.dart
│   │   └── ...
│   ├── repositories/                   # 仓库实现
│   │   └── intel_repository_impl.dart
│   ├── sources/                        # 数据源
│   │   ├── intel_remote_source.dart    # HTTP API
│   │   └── intel_realtime_source.dart  # WebSocket
│   └── mappers/                        # 映射器
│       └── intel_mapper.dart
│
└── presentation/                       # 表现层
    ├── pages/                          # 页面
    │   └── intel_page.dart
    ├── cubits/                         # 状态管理
    │   ├── intel/
    │   │   ├── intel_cubit.dart        # 主协调器
    │   │   └── intel_state.dart
    │   ├── event_list/
    │   │   ├── event_list_cubit.dart
    │   │   └── event_list_state.dart
    │   ├── signal_list/
    │   │   ├── signal_list_cubit.dart
    │   │   └── signal_list_state.dart
    │   └── unread/
    │       ├── unread_cubit.dart
    │       └── unread_state.dart
    └── widgets/                        # UI组件
        ├── intel_list/
        ├── intelligence_type/
        ├── intel_item/
        └── ...
```

---

## 三、分层设计详情

### 3.1 Domain 层 - 实体设计

**IntelEntity** (核心实体):
```dart
@freezed
sealed class IntelEntity with _$IntelEntity {
  const factory IntelEntity({
    required String id,
    required IntelType type,
    required Multilingual title,
    required Multilingual content,
    required DateTime publishedAt,
    required DateTime createdAt,
    List<String>? tokenKeys,
    List<TokenEntity>? tokens,
    List<MediaEntity>? medias,
    AIAgentEntity? aiAgent,
    AuthorEntity? author,
    Multilingual? analyzed,
    double? analyzedTime,
    double? monitorTime,
    // ... 其他字段
  }) = _IntelEntity;
}

@freezed
sealed class IntelType with _$IntelType {
  const factory IntelType.event() = IntelTypeEvent;
  const factory IntelType.twitter() = IntelTypeTwitter;
  const factory IntelType.telegram() = IntelTypeTelegram;
  const factory IntelType.news() = IntelTypeNews;
  const factory IntelType.radarSignal() = IntelTypeRadarSignal;
}
```

### 3.2 Domain 层 - 仓库接口

```dart
abstract class IntelRepository {
  // 获取情报历史
  Future<Result<List<IntelEntity>>> getEventIntelligence({
    int? page,
    int? pageSize,
  });

  Future<Result<List<IntelEntity>>> getSignalIntelligence({
    required String chainId,
    int? page,
    int? pageSize,
  });

  // Token数据
  Future<Result<Map<String, List<TokenEntity>>>> getTokensByIntelIds(
    List<String> intelIds,
  );

  // 实时数据流
  Stream<IntelEntity> subscribeRealtimeIntel();
  Future<void> connectRealtime();
  Future<void> disconnectRealtime();
}
```

### 3.3 Domain 层 - 用例

```dart
// 获取事件类情报
class FetchEventIntelligence {
  final IntelRepository _repository;

  FetchEventIntelligence(this._repository);

  Future<Result<List<IntelEntity>>> call({int? page, int? pageSize}) {
    return _repository.getEventIntelligence(page: page, pageSize: pageSize);
  }
}

// 订阅实时情报
class SubscribeRealtimeIntel {
  final IntelRepository _repository;

  SubscribeRealtimeIntel(this._repository);

  Stream<IntelEntity> call() => _repository.subscribeRealtimeIntel();
}
```

### 3.4 Data 层 - 数据源

**IntelRemoteSource** (HTTP):
```dart
class IntelRemoteSource {
  final DioClient _dioClient;
  static const String _basePath = '/api/v1/intelligence';

  Future<List<IntelModel>> fetchEventIntelligence({...});
  Future<List<IntelModel>> fetchSignalIntelligence({...});
  Future<Map<String, List<TokenModel>>> fetchTokensByIntelIds(List<String> ids);
}
```

**IntelRealtimeSource** (WebSocket):
```dart
class IntelRealtimeSource {
  final WebSocketService _webSocketService;

  Stream<IntelModel> get intelStream => _controller.stream;
  Future<void> connect();
  Future<void> disconnect();
  void sendSubscription(List<String> agentIds);
}
```

### 3.5 Presentation 层 - Cubit 设计

采用**多Cubit协调模式**（参考Swap模块）:

```dart
// 主协调器
class IntelCubit extends Cubit<IntelState> {
  final EventListCubit _eventListCubit;
  final SignalListCubit _signalListCubit;
  final UnreadCubit _unreadCubit;
  final SubscribeRealtimeIntel _subscribeRealtimeIntel;

  // 协调子Cubit，处理跨Cubit业务逻辑
}

// 事件列表Cubit
class EventListCubit extends Cubit<EventListState> {
  final FetchEventIntelligence _fetchEventIntelligence;
  final FetchIntelTokens _fetchIntelTokens;

  Future<void> loadInitial();
  Future<void> loadMore();
  Future<void> refresh();
  void updateWithRealtimeIntel(IntelEntity intel);
}

// 未读管理Cubit
class UnreadCubit extends Cubit<UnreadState> {
  void addUnread(IntelEntity intel);
  void removeUnread(String id);
  void clearAll();
}
```

---

## 四、DI 模块注册

```dart
// lib/core/di/modules/intel_module.dart
class IntelModule implements InjectionModule {
  final GetIt _sl;

  @override
  Future<void> init() async {
    // ========== Data Sources ==========
    _sl.registerLazySingleton(() => IntelRemoteSource(_sl<DioClient>()));
    _sl.registerLazySingleton(() => IntelRealtimeSource(_sl<WebSocketService>()));

    // ========== Repositories ==========
    _sl.registerLazySingleton<IntelRepository>(
      () => IntelRepositoryImpl(_sl(), _sl()),
    );

    // ========== Use Cases ==========
    _sl.registerLazySingleton(() => FetchEventIntelligence(_sl()));
    _sl.registerLazySingleton(() => FetchSignalIntelligence(_sl()));
    _sl.registerLazySingleton(() => FetchIntelTokens(_sl()));
    _sl.registerLazySingleton(() => SubscribeRealtimeIntel(_sl()));

    // ========== Sub Cubits ==========
    _sl.registerFactory(() => EventListCubit(_sl(), _sl()));
    _sl.registerFactory(() => SignalListCubit(_sl(), _sl()));
    _sl.registerFactory(() => UnreadCubit());

    // ========== Main Cubit ==========
    _sl.registerFactory(() => IntelCubit(
      eventListCubit: _sl(),
      signalListCubit: _sl(),
      unreadCubit: _sl(),
      subscribeRealtimeIntel: _sl(),
    ));
  }
}
```

---

## 五、迁移步骤（渐进式）

### Phase 1: 基础架构 (Domain层)
1. [ ] 创建 Feature Flag 配置 `lib/core/feature_flags/feature_flags.dart`
2. [ ] 创建 `lib/features/intel/domain/entities/` 目录及实体
3. [ ] 创建 `lib/features/intel/domain/repositories/intel_repository.dart`
4. [ ] 创建 `lib/features/intel/domain/usecases/` 目录及用例

### Phase 2: 数据层
5. [ ] 创建 `data/models/` 目录，新建 Model (可复用旧模型的 JSON 逻辑)
6. [ ] 创建 `data/sources/intel_remote_source.dart`
7. [ ] 创建 `data/sources/intel_realtime_source.dart` (WebSocket 最佳实践)
8. [ ] 创建 `data/repositories/intel_repository_impl.dart`
9. [ ] 创建 `data/mappers/intel_mapper.dart` (Model ↔ Entity)

### Phase 3: 表现层
10. [ ] 创建 `presentation/cubits/` 目录及子Cubit (EventList, SignalList, Unread)
11. [ ] 创建主协调器 `presentation/cubits/intel/intel_cubit.dart`
12. [ ] 创建 `presentation/pages/intel_page.dart`
13. [ ] 迁移 widgets 到 `presentation/widgets/` (复制，不删除旧文件)

### Phase 4: DI 集成
14. [ ] 创建 `lib/core/di/modules/intel_module.dart`
15. [ ] 在 `injection_container.dart` 注册模块
16. [ ] 更新路由配置 (使用 Feature Flag 切换)

### Phase 5: 验证 & 灰度
17. [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`
18. [ ] 运行 `flutter analyze`
19. [ ] 内部测试 (Feature Flag = false, 仅开发环境)
20. [ ] Staging 环境验证 (Feature Flag = true)
21. [ ] 灰度发布

### Phase 6: 清理（全量发布后）
22. [ ] 删除旧代码 `lib/screens/intel/`
23. [ ] 删除旧代码 `lib/cubits/intel/`
24. [ ] 移除 Feature Flag 相关代码
25. [ ] 更新路由为直接引用新架构

---

## 六、关键文件清单

### 需要创建的文件
| 路径 | 说明 |
|------|------|
| `domain/entities/intel_entity.dart` | 情报实体 |
| `domain/entities/token_entity.dart` | Token实体 |
| `domain/entities/ai_agent_entity.dart` | AI Agent实体 |
| `domain/entities/author_entity.dart` | 作者实体 |
| `domain/entities/media_entity.dart` | 媒体实体 |
| `domain/repositories/intel_repository.dart` | 仓库接口 |
| `domain/usecases/fetch_event_intelligence.dart` | 用例 |
| `domain/usecases/fetch_signal_intelligence.dart` | 用例 |
| `domain/usecases/fetch_intel_tokens.dart` | 用例 |
| `domain/usecases/subscribe_realtime_intel.dart` | 用例 |
| `data/models/intel_model.dart` | DTO模型 |
| `data/sources/intel_remote_source.dart` | HTTP数据源 |
| `data/sources/intel_realtime_source.dart` | WebSocket数据源 |
| `data/repositories/intel_repository_impl.dart` | 仓库实现 |
| `data/mappers/intel_mapper.dart` | 模型-实体映射 |
| `presentation/cubits/intel/intel_cubit.dart` | 主Cubit |
| `presentation/cubits/intel/intel_state.dart` | 主状态 |
| `presentation/cubits/event_list/event_list_cubit.dart` | 事件列表Cubit |
| `presentation/cubits/signal_list/signal_list_cubit.dart` | 信号列表Cubit |
| `presentation/cubits/unread/unread_cubit.dart` | 未读Cubit |
| `presentation/pages/intel_page.dart` | 主页面 |

### 需要迁移的Widget (33个)
所有 `lib/screens/intel/widgets/` 下的文件迁移到 `presentation/widgets/`

---

## 七、注意事项

1. **WebSocket处理**: 将WebSocket逻辑封装到 `IntelRealtimeSource`，Cubit只监听Stream
2. **轮询服务**: Token价格轮询可以独立为 `IntelPollingService` 或在Cubit中处理
3. **OptionsCubit依赖**: 通过DI注入，保持跨Feature协调
4. **状态同步**: 使用Stream订阅机制同步子Cubit状态到主Cubit
5. **Result类型**: 所有仓库方法使用 `Result<T>` 包装返回值
6. **生成代码**: 每次修改Freezed模型后运行 `build_runner`

---

## 八、预估工作量

| Phase | 任务 | 预估文件数 |
|-------|------|-----------|
| Phase 1 | Domain层 | ~8文件 |
| Phase 2 | Data层 | ~6文件 |
| Phase 3 | Presentation层 | ~8文件 + 33widgets |
| Phase 4 | DI集成 | ~2文件 |
| Phase 5 | 验证清理 | - |

**总计**: 约 50+ 文件需要创建/修改

---

## 九、设计决策（已确认）

| 决策项 | 选择 | 说明 |
|--------|------|------|
| 模型处理 | **B - Model/Entity分离** | 创建纯净的Domain Entity，Data层Model负责JSON序列化 |
| OptionsCubit依赖 | **A - 保持跨Feature依赖** | 通过DI注入OptionsCubit |
| 迁移方式 | **B - 渐进式迁移** | 保留旧代码，通过Feature Flag切换，验证后再删除 |
| WebSocket | **优化重构** | 遵循最佳实践，抽象为独立数据源 |

---

## 十、WebSocket 最佳实践设计

### 10.1 架构设计

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                    │
│  ┌─────────────┐                                        │
│  │ IntelCubit  │ ← 监听 Stream<IntelEntity>             │
│  └─────────────┘                                        │
└─────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────┐
│                      Domain Layer                        │
│  ┌────────────────────────┐  ┌─────────────────────┐   │
│  │ SubscribeRealtimeIntel │  │ IntelRepository     │   │
│  │ (UseCase)              │  │ (Interface)         │   │
│  └────────────────────────┘  └─────────────────────┘   │
└─────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────┐
│                       Data Layer                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │           IntelRealtimeSource                    │   │
│  │  ┌─────────────────────────────────────────┐    │   │
│  │  │ • 连接管理 (connect/disconnect/reconnect)│    │   │
│  │  │ • 心跳保活 (ping/pong)                   │    │   │
│  │  │ • 订阅管理 (subscribe/unsubscribe)       │    │   │
│  │  │ • 消息解析 (JSON → Model → Entity)       │    │   │
│  │  │ • 错误处理 & 自动重连                    │    │   │
│  │  │ • 状态广播 (ConnectionStatus)            │    │   │
│  │  └─────────────────────────────────────────┘    │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

### 10.2 IntelRealtimeSource 设计

```dart
/// lib/features/intel/data/sources/intel_realtime_source.dart

enum RealtimeConnectionStatus {
  disconnected,
  connecting,
  connected,
  reconnecting,
  error,
}

class IntelRealtimeSource {
  final WebSocketService _webSocketService;

  // 状态流
  final _statusController = BehaviorSubject<RealtimeConnectionStatus>.seeded(
    RealtimeConnectionStatus.disconnected,
  );

  // 情报消息流
  final _intelController = StreamController<IntelModel>.broadcast();

  // 心跳定时器
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;

  // 重连配置
  static const _initialReconnectDelay = Duration(seconds: 1);
  static const _maxReconnectDelay = Duration(seconds: 30);
  int _reconnectAttempts = 0;

  // 订阅ID列表（动态管理）
  final Set<String> _subscriptions = {};

  Stream<RealtimeConnectionStatus> get statusStream => _statusController.stream;
  Stream<IntelModel> get intelStream => _intelController.stream;
  RealtimeConnectionStatus get currentStatus => _statusController.value;

  /// 连接WebSocket
  Future<void> connect() async {
    if (currentStatus == RealtimeConnectionStatus.connected ||
        currentStatus == RealtimeConnectionStatus.connecting) {
      return;
    }

    _statusController.add(RealtimeConnectionStatus.connecting);

    try {
      await _webSocketService.connect();
      _statusController.add(RealtimeConnectionStatus.connected);
      _reconnectAttempts = 0;
      _startHeartbeat();
      _resubscribeAll();
    } catch (e) {
      _statusController.add(RealtimeConnectionStatus.error);
      _scheduleReconnect();
    }
  }

  /// 断开连接
  Future<void> disconnect() async {
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    await _webSocketService.disconnect();
    _statusController.add(RealtimeConnectionStatus.disconnected);
  }

  /// 订阅Agent
  void subscribe(String agentId) {
    _subscriptions.add(agentId);
    if (currentStatus == RealtimeConnectionStatus.connected) {
      _sendSubscription(agentId);
    }
  }

  /// 取消订阅
  void unsubscribe(String agentId) {
    _subscriptions.remove(agentId);
    if (currentStatus == RealtimeConnectionStatus.connected) {
      _sendUnsubscription(agentId);
    }
  }

  /// 批量订阅（初始化用）
  void subscribeAll(List<String> agentIds) {
    _subscriptions.addAll(agentIds);
    if (currentStatus == RealtimeConnectionStatus.connected) {
      _sendInitSubscription();
    }
  }

  // ========== Private Methods ==========

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (currentStatus == RealtimeConnectionStatus.connected) {
        _webSocketService.sendMessage({'type': 'ping'});
      }
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    final delay = _calculateReconnectDelay();
    _statusController.add(RealtimeConnectionStatus.reconnecting);

    _reconnectTimer = Timer(delay, () {
      _reconnectAttempts++;
      connect();
    });
  }

  Duration _calculateReconnectDelay() {
    // 指数退避算法
    final delay = _initialReconnectDelay * pow(2, _reconnectAttempts);
    return delay > _maxReconnectDelay ? _maxReconnectDelay : delay;
  }

  void _resubscribeAll() {
    if (_subscriptions.isNotEmpty) {
      _sendInitSubscription();
    }
  }

  void _sendInitSubscription() {
    _webSocketService.sendMessage({
      'type': 'init',
      'data': {'subscriptions': _subscriptions.join('#')},
    });
  }

  void _sendSubscription(String agentId) {
    _webSocketService.sendMessage({
      'type': 'follow_agent',
      'data': {'subset_id': agentId},
    });
  }

  void _sendUnsubscription(String agentId) {
    _webSocketService.sendMessage({
      'type': 'unfollow_agent',
      'data': {'subset_id': agentId},
    });
  }

  void _handleMessage(dynamic message) {
    if (message is! Map) return;

    switch (message['type']) {
      case 'welcome':
        // 连接确认
        break;
      case 'pong':
        // 心跳响应
        break;
      case 'message':
        _handleIntelMessage(message);
        break;
      case 'error':
        _handleError(message);
        break;
    }
  }

  void _handleIntelMessage(Map<String, dynamic> message) {
    try {
      final intelMessage = IntelMessageModel.fromJson(message);
      if (intelMessage.data != null) {
        _intelController.add(intelMessage.data!);
      }
    } catch (e) {
      // 解析错误处理
    }
  }

  void _handleError(Map<String, dynamic> message) {
    // 错误上报
  }

  Future<void> dispose() async {
    await disconnect();
    await _statusController.close();
    await _intelController.close();
  }
}
```

### 10.3 Repository 集成

```dart
/// lib/features/intel/data/repositories/intel_repository_impl.dart

class IntelRepositoryImpl implements IntelRepository {
  final IntelRemoteSource _remoteSource;
  final IntelRealtimeSource _realtimeSource;

  @override
  Stream<IntelEntity> subscribeRealtimeIntel() {
    return _realtimeSource.intelStream.map((model) => model.toEntity());
  }

  @override
  Stream<RealtimeConnectionStatus> get connectionStatus {
    return _realtimeSource.statusStream;
  }

  @override
  Future<void> connectRealtime({List<String>? agentIds}) async {
    await _realtimeSource.connect();
    if (agentIds != null && agentIds.isNotEmpty) {
      _realtimeSource.subscribeAll(agentIds);
    }
  }

  @override
  Future<void> disconnectRealtime() async {
    await _realtimeSource.disconnect();
  }

  @override
  void subscribeAgent(String agentId) {
    _realtimeSource.subscribe(agentId);
  }

  @override
  void unsubscribeAgent(String agentId) {
    _realtimeSource.unsubscribe(agentId);
  }
}
```

### 10.4 Use Case 设计

```dart
/// 订阅实时情报
class SubscribeRealtimeIntel {
  final IntelRepository _repository;

  Stream<IntelEntity> call() => _repository.subscribeRealtimeIntel();
}

/// 管理WebSocket连接
class ManageRealtimeConnection {
  final IntelRepository _repository;

  Future<void> connect({List<String>? agentIds}) =>
    _repository.connectRealtime(agentIds: agentIds);

  Future<void> disconnect() => _repository.disconnectRealtime();

  Stream<RealtimeConnectionStatus> get status => _repository.connectionStatus;
}

/// 管理Agent订阅
class ManageAgentSubscription {
  final IntelRepository _repository;

  void subscribe(String agentId) => _repository.subscribeAgent(agentId);
  void unsubscribe(String agentId) => _repository.unsubscribeAgent(agentId);
}
```

---

## 十一、渐进式迁移策略

### 11.1 Feature Flag 设计

```dart
/// lib/core/feature_flags/feature_flags.dart

abstract class FeatureFlags {
  /// Intel 模块使用新架构
  static bool get useNewIntelFeature {
    // 可通过远程配置、环境变量或本地设置控制
    return AppConfig().env.useNewIntelFeature ?? false;
  }
}
```

### 11.2 路由切换

```dart
/// lib/core/router/routes/intel_route.dart

GoRoute(
  path: '/intel',
  builder: (context, state) {
    if (FeatureFlags.useNewIntelFeature) {
      // 新架构
      return BlocProvider(
        create: (_) => getIt<IntelCubit>(),
        child: const IntelPage(),
      );
    } else {
      // 旧架构
      return const IntelScreen();
    }
  },
),
```

### 11.3 迁移阶段

| 阶段 | 状态 | 说明 |
|------|------|------|
| **Phase 1** | `useNewIntelFeature = false` | 新代码开发完成，仅内部测试 |
| **Phase 2** | `useNewIntelFeature = true` (staging) | Staging 环境验证 |
| **Phase 3** | `useNewIntelFeature = true` (灰度) | 部分生产用户灰度 |
| **Phase 4** | `useNewIntelFeature = true` (全量) | 全量发布 |
| **Phase 5** | 删除旧代码 | 移除 `lib/screens/intel/` 和 `lib/cubits/intel/` |

### 11.4 文件保留策略

迁移期间保留的旧文件：
```
lib/screens/intel/           # 保留，Phase 5 删除
lib/cubits/intel/            # 保留，Phase 5 删除
lib/data/models/intel/       # 保留，新代码可复用部分逻辑
lib/data/services/api/intel_api.dart  # 保留，可被新架构复用
```

新建文件：
```
lib/features/intel/          # 新架构代码
lib/core/feature_flags/      # Feature Flag 配置
```
