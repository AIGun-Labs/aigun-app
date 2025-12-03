# SwapCubit 重构文档

## 目录

1. [重构背景](#重构背景)
2. [架构设计](#架构设计)
3. [核心组件详解](#核心组件详解)
4. [依赖注入配置](#依赖注入配置)
5. [页面使用指南](#页面使用指南)
6. [事件处理](#事件处理)
7. [最佳实践](#最佳实践)

---

## 重构背景

### 原始问题

原 `SwapCubit` 存在以下问题：

1. **单一职责违反**: 977 行代码，承担了 Token 选择、余额查询、询价、交易执行、UI 导航等多种职责
2. **状态管理混乱**: 多个 Timer、Polling 服务混杂在一起
3. **难以测试**: 紧耦合导致单元测试困难
4. **UI 耦合**: Toast、Navigation 逻辑嵌入业务代码

### 重构目标

- 遵循单一职责原则 (SRP)
- 采用协调器模式管理多个子 Cubit
- 事件驱动解耦 UI 操作
- 提高可测试性和可维护性

---

## 架构设计

### 整体架构图

```
┌─────────────────────────────────────────────────────────────┐
│                        UI Layer                              │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                   TradePage                          │    │
│  │  - BlocListener<SwapCubit, SwapState> (事件监听)    │    │
│  │  - BlocBuilder<SwapCubit, SwapState> (状态渲染)     │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Coordinator Layer                         │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                    SwapCubit                         │    │
│  │  - 协调子 Cubit                                      │    │
│  │  - 聚合状态到 SwapState                              │    │
│  │  - 发出 SwapEvent 供 UI 响应                         │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
          │                    │                    │
          ▼                    ▼                    ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│ TokenSelection  │ │   QuoteCubit    │ │ TransactionCubit│
│     Cubit       │ │                 │ │                 │
│ ─────────────── │ │ ─────────────── │ │ ─────────────── │
│ • Token 选择    │ │ • 询价请求      │ │ • 交易执行      │
│ • 余额轮询      │ │ • 定时刷新      │ │ • 状态轮询      │
│ • Token 搜索    │ │ • 参数验证      │ │ • 回调通知      │
└─────────────────┘ └─────────────────┘ └─────────────────┘
```

### 文件结构

```
lib/features/swap/presentation/cubit/
├── swap/
│   ├── swap_cubit.dart          # 主协调器
│   ├── swap_state.dart          # 聚合状态
│   ├── swap_state.freezed.dart  # Freezed 生成
│   └── swap_event.dart          # UI 事件定义
├── token_selection/
│   ├── token_selection_cubit.dart
│   ├── token_selection_state.dart
│   └── token_selection_state.freezed.dart
├── quote/
│   ├── quote_cubit.dart
│   ├── quote_state.dart
│   └── quote_state.freezed.dart
└── transaction/
    ├── transaction_cubit.dart
    ├── transaction_state.dart
    └── transaction_state.freezed.dart
```

---

## 核心组件详解

### 1. SwapCubit (协调器)

**职责**: 协调子 Cubit，聚合状态，发出 UI 事件

```dart
class SwapCubit extends Cubit<SwapState> {
  // 依赖的子 Cubit
  final TokenSelectionCubit _tokenSelectionCubit;
  final QuoteCubit _quoteCubit;
  final TransactionCubit _transactionCubit;

  // Stream 订阅，用于同步子 Cubit 状态
  StreamSubscription? _tokenSelectionSub;
  StreamSubscription? _quoteSub;
  StreamSubscription? _transactionSub;

  SwapCubit({...}) : super(const SwapState()) {
    _setupSubscriptions();      // 订阅子 Cubit
    _setupTransactionCallbacks(); // 设置交易回调
    _syncInitialState();        // 同步初始状态
  }

  // 监听子 Cubit 状态变化，同步到主状态
  void _setupSubscriptions() {
    _tokenSelectionSub = _tokenSelectionCubit.stream.listen(_onTokenSelectionChanged);
    _quoteSub = _quoteCubit.stream.listen(_onQuoteChanged);
    _transactionSub = _transactionCubit.stream.listen(_onTransactionChanged);
  }
}
```

**关键方法**:

| 方法 | 说明 |
|------|------|
| `updateFromToken()` | 更新源 Token |
| `updateToToken()` | 更新目标 Token |
| `swapToken()` | 交换源/目标 Token |
| `updateAmount()` | 更新交易金额 |
| `getQuote()` | 获取报价 |
| `swap()` | 执行交易 |
| `clearEvent()` | 清除事件（UI 消费后调用） |

### 2. TokenSelectionCubit

**职责**: Token 选择、余额轮询、Token 搜索

```dart
class TokenSelectionCubit extends Cubit<TokenSelectionState> {
  final BalanceCubit _balanceCubit;
  final TokenSwapStorage _tokenSwapStorage;
  final GetNativeTokens _getNativeTokens;
  final SearchTokens _searchTokens;

  PollingService<double?>? _balancePollingService;

  // 初始化时加载保存的 Token 并启动余额轮询
  Future<void> _init() async {
    await _loadSavedTokens();
    await _loadNativeTokens();
    _startBalancePolling();
    _setupBalanceCubitListener();
  }

  // 余额轮询使用 PollingService
  void _startBalancePolling() {
    _balancePollingService = PollingService<double?>(
      baseInterval: Duration(seconds: 10),
      fetcher: (cancelToken) async => _fetchBalance(),
      onData: _handleBalanceUpdate,
    )..start();
  }
}
```

**状态定义**:

```dart
@freezed
sealed class TokenSelectionState with _$TokenSelectionState {
  const factory TokenSelectionState({
    @Default(defaultFormTradeToken) TransactionEntity? fromToken,
    @Default(defaultTradeToken) TransactionEntity? toToken,
    @Default([]) List<TokenEntity> availableTokens,
    @Default([]) List<TokenEntity> nativeTokens,
    @Default(null) double? fromBalance,
    @Default(TokenBalanceStatus.initial()) TokenBalanceStatus balanceStatus,
    @Default(TokenSearchStatus.initial()) TokenSearchStatus searchStatus,
  }) = _TokenSelectionState;
}
```

### 3. QuoteCubit

**职责**: 询价请求、定时刷新、防抖处理

```dart
class QuoteCubit extends Cubit<QuoteState> {
  final GetQuote _getQuote;
  final ValidateSwapParams _validateSwapParams;

  Timer? _quoteTimer;
  final Debouncer _quoteDebouncer = Debouncer(delay: Duration(milliseconds: 300));

  // 带防抖的询价
  void _requestQuoteWithDebounce() {
    _quoteDebouncer.run(() => getQuote());
  }

  // 执行询价
  Future<void> getQuote() async {
    // 1. 验证参数
    final validation = _validateSwapParams.callForQuote(...);
    if (!validation.isSuccess) {
      emit(state.copyWith(paramsStatus: const QuoteParamsStatus.invalid()));
      return;
    }

    // 2. 发起请求
    emit(state.copyWith(status: const QuoteStatus.loading()));
    final result = await _getQuote(...);

    // 3. 处理结果
    result.whenOrNull(
      success: (quote) {
        emit(state.copyWith(
          status: QuoteStatus.success(quote),
          quote: quote,
        ));
        _startQuoteTimer(); // 启动定时刷新
      },
      failure: (message) {
        emit(state.copyWith(status: QuoteStatus.failure(message)));
      },
    );
  }
}
```

### 4. TransactionCubit

**职责**: 交易执行、状态轮询、结果回调

```dart
class TransactionCubit extends Cubit<TransactionState> {
  final ExecuteSwap _executeSwap;
  final GetTransactionStatus _getTransactionStatus;

  PollingService<Result<TransactionStatusEntity>>? _pollingService;

  // 回调函数，供 SwapCubit 注册
  void Function(SwapResultEntity result)? onTransactionSuccess;
  void Function(String? message)? onTransactionFailure;

  Future<void> executeSwap({
    required TransactionEntity fromToken,
    required TransactionEntity toToken,
    required String amount,
    required TradeCustomSetting options,
    required TradeMode mode,
  }) async {
    emit(state.copyWith(status: const TransactionStatus.submitting()));

    final result = await _executeSwap.call(...);

    result.whenOrNull(
      success: (transaction) {
        emit(state.copyWith(
          status: TransactionStatus.polling(txHash: transaction.txHash ?? ''),
        ));
        _startTransactionStatusPolling(transaction, fromToken);
      },
      failure: (error) {
        emit(state.copyWith(status: TransactionStatus.failure(error)));
        onTransactionFailure?.call(error);
      },
    );
  }

  // 交易状态轮询
  void _startTransactionStatusPolling(SwapResultEntity transaction, TransactionEntity fromToken) {
    _pollingService = PollingService<Result<TransactionStatusEntity>>(
      baseInterval: Duration(seconds: 2),
      fetcher: (cancel) => _getTransactionStatus(...),
      onData: (data) => _handleTransactionStatus(data, transaction),
    )..start();
  }
}
```

### 5. SwapEvent (事件定义)

**职责**: 定义一次性 UI 事件（Toast、导航等）

```dart
@freezed
sealed class SwapEvent with _$SwapEvent {
  /// 显示加载中
  const factory SwapEvent.showLoading() = _ShowLoading;

  /// 隐藏加载
  const factory SwapEvent.hideLoading() = _HideLoading;

  /// 参数验证失败
  const factory SwapEvent.showParamsInvalid() = _ShowParamsInvalid;

  /// 显示错误信息
  const factory SwapEvent.showError(String message) = _ShowError;

  /// 交易成功
  const factory SwapEvent.showSuccess({
    required String message,
    required String txHash,
    required String symbol,
    required String amount,
    String? txUrl,
  }) = _ShowSuccess;

  /// 导航到结果页
  const factory SwapEvent.navigateToResult(SwapResultEntity result) = _NavigateToResult;
}
```

---

## 依赖注入配置

在 `lib/core/di/modules/swap_module.dart` 中配置：

```dart
class SwapModule implements InjectionModule {
  final GetIt _sl;

  SwapModule(this._sl);

  @override
  Future<void> init() async {
    // ==================== Use Cases ====================
    _sl.registerLazySingleton(() => ValidateSwapParams());

    // ==================== Sub Cubits ====================
    _sl.registerFactory(() => TokenSelectionCubit(
      balanceCubit: _sl<BalanceCubit>(),
      tokenSwapStorage: _sl<TokenSwapStorage>(),
      getNativeTokens: _sl<GetNativeTokens>(),
      searchTokens: _sl<SearchTokens>(),
    ));

    _sl.registerFactory(() => QuoteCubit(
      getQuote: _sl<GetQuote>(),
      tradeSettingCubit: _sl<TradeSettingCubit>(),
      validateSwapParams: _sl<ValidateSwapParams>(),
    ));

    _sl.registerFactory(() => TransactionCubit(
      executeSwap: _sl<ExecuteSwap>(),
      getTransactionStatus: _sl<GetTransactionStatus>(),
      walletStorage: _sl<WalletStorage>(),
    ));

    // ==================== Main Coordinator ====================
    _sl.registerFactory(() => SwapCubit(
      tokenSelectionCubit: _sl<TokenSelectionCubit>(),
      quoteCubit: _sl<QuoteCubit>(),
      transactionCubit: _sl<TransactionCubit>(),
      tradeSettingCubit: _sl<TradeSettingCubit>(),
      walletCubit: _sl<WalletCubit>(),
      balanceCubit: _sl<BalanceCubit>(),
      validateSwapParams: _sl<ValidateSwapParams>(),
    ));
  }
}
```

---

## 页面使用指南

### 方式一：全局 Provider (推荐)

在 `GlobalProvide` 中注册（已配置）：

```dart
// lib/widgets/global_provide.dart
class GlobalProvide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ... 其他 providers
        BlocProvider(create: (context) => getIt<SwapCubit>()),
      ],
      child: child,
    );
  }
}
```

### 方式二：页面级 Provider

```dart
class TradePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SwapCubit>(),
      child: const _TradePageContent(),
    );
  }
}
```

### 页面实现示例

```dart
class _TradePageContent extends StatefulWidget {
  @override
  State<_TradePageContent> createState() => _TradePageContentState();
}

class _TradePageContentState extends State<_TradePageContent>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // 应用生命周期管理
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final swapCubit = context.read<SwapCubit>();
    if (state == AppLifecycleState.paused) {
      swapCubit.pauseTimers();  // 暂停轮询
    } else if (state == AppLifecycleState.resumed) {
      swapCubit.resumeTimers(); // 恢复轮询
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwapCubit, SwapState>(
      listenWhen: (previous, current) => previous.event != current.event,
      listener: _handleSwapEvent,
      child: BlocBuilder<SwapCubit, SwapState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                _buildFromTokenSelector(state),
                _buildAmountInput(state),
                _buildToTokenSelector(state),
                _buildQuoteInfo(state),
                _buildSwapButton(state),
              ],
            ),
          );
        },
      ),
    );
  }

  // 事件处理
  void _handleSwapEvent(BuildContext context, SwapState state) {
    final event = state.event;
    if (event == null) return;

    // 消费事件后清除
    context.read<SwapCubit>().clearEvent();

    event.when(
      showLoading: () => _showLoadingDialog(),
      hideLoading: () => Navigator.of(context).pop(),
      showParamsInvalid: () => _showParamsInvalidToast(),
      showError: (message) => _showErrorToast(message),
      showSuccess: (message, txHash, symbol, amount, txUrl) {
        _showSuccessToast(message, symbol, amount);
      },
      navigateToResult: (result) {
        context.pushNamed(RouteNames.tradeResult, extra: result);
      },
    );
  }

  // Token 选择器
  Widget _buildFromTokenSelector(SwapState state) {
    return TokenSelector(
      token: state.fromToken,
      balance: state.fromBalance,
      onTap: () => _showTokenSelectorSheet(isFrom: true),
    );
  }

  // 金额输入
  Widget _buildAmountInput(SwapState state) {
    return AmountInput(
      amount: state.amount,
      onChanged: (value) => context.read<SwapCubit>().updateAmount(value),
      onMaxPressed: () => context.read<SwapCubit>().updateAmountToMax(),
    );
  }

  // 交换按钮
  Widget _buildSwapButton(SwapState state) {
    return SwapButton(
      isLoading: state.isTrading,
      isEnabled: state.canTrade,
      onPressed: () => context.read<SwapCubit>().swap(context),
    );
  }
}
```

### 选择 Token 的实现

```dart
void _showTokenSelectorSheet({required bool isFrom}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => BlocBuilder<SwapCubit, SwapState>(
      builder: (context, state) {
        return TokenSelectorSheet(
          tokens: state.nativeTokens,
          searchStatus: state.searchStatus,
          onSearch: (keyword) => context.read<SwapCubit>().searchTokens(keyword),
          onReset: () => context.read<SwapCubit>().resetSearch(),
          onSelect: (token) {
            final entity = token.toTransactionEntity();
            if (isFrom) {
              context.read<SwapCubit>().updateFromToken(entity);
            } else {
              context.read<SwapCubit>().updateToToken(entity);
            }
            Navigator.pop(context);
          },
        );
      },
    ),
  );
}
```

---

## 事件处理

### 事件流程图

```
SwapCubit                           UI Layer
    │                                   │
    │ emit(state.copyWith(              │
    │   event: SwapEvent.showSuccess()  │
    │ ))                                │
    │ ─────────────────────────────────>│
    │                                   │ BlocListener 触发
    │                                   │
    │                                   │ 显示 Toast
    │                                   │
    │ clearEvent()                      │
    │ <─────────────────────────────────│
    │                                   │
```

### 事件监听最佳实践

```dart
BlocListener<SwapCubit, SwapState>(
  // 只在 event 变化时触发
  listenWhen: (previous, current) =>
      previous.event != current.event && current.event != null,
  listener: (context, state) {
    final event = state.event;
    if (event == null) return;

    // 立即清除事件，防止重复触发
    context.read<SwapCubit>().clearEvent();

    // 处理事件
    event.map(
      showLoading: (_) => showLoadingOverlay(context),
      hideLoading: (_) => hideLoadingOverlay(context),
      showParamsInvalid: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).invalidParams)),
        );
      },
      showError: (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      },
      showSuccess: (e) {
        TradeStatusToast.showSuccess(
          context: context,
          symbol: e.symbol,
          amount: e.amount,
          txUrl: e.txUrl,
        );
      },
      navigateToResult: (e) {
        context.pushNamed(RouteNames.tradeResult, extra: e.result);
      },
    );
  },
  child: // ...
)
```

---

## 最佳实践

### 1. 状态访问

```dart
// 推荐：使用 context.read 访问方法
context.read<SwapCubit>().updateAmount(value);

// 推荐：使用 context.watch 监听状态变化（在 build 中）
final state = context.watch<SwapCubit>().state;

// 推荐：使用 BlocBuilder 进行局部重建
BlocBuilder<SwapCubit, SwapState>(
  buildWhen: (previous, current) => previous.quote != current.quote,
  builder: (context, state) => QuoteDisplay(quote: state.quote),
)
```

### 2. 生命周期管理

```dart
class _TradePageState extends State<TradePage> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cubit = context.read<SwapCubit>();
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        cubit.pauseTimers();
        break;
      case AppLifecycleState.resumed:
        cubit.resumeTimers();
        break;
      default:
        break;
    }
  }
}
```

### 3. 错误处理

```dart
BlocListener<SwapCubit, SwapState>(
  listenWhen: (prev, curr) => curr.swapStatus is SwapStatusFailure,
  listener: (context, state) {
    final status = state.swapStatus;
    if (status is SwapStatusFailure) {
      // 显示错误对话框或 Toast
      showErrorDialog(context, status.message);
    }
  },
  child: // ...
)
```

### 4. 测试示例

```dart
void main() {
  group('SwapCubit', () {
    late SwapCubit swapCubit;
    late MockTokenSelectionCubit mockTokenSelection;
    late MockQuoteCubit mockQuote;
    late MockTransactionCubit mockTransaction;

    setUp(() {
      mockTokenSelection = MockTokenSelectionCubit();
      mockQuote = MockQuoteCubit();
      mockTransaction = MockTransactionCubit();

      swapCubit = SwapCubit(
        tokenSelectionCubit: mockTokenSelection,
        quoteCubit: mockQuote,
        transactionCubit: mockTransaction,
        // ... 其他依赖
      );
    });

    blocTest<SwapCubit, SwapState>(
      'updates amount and triggers quote',
      build: () => swapCubit,
      act: (cubit) => cubit.updateAmount('100'),
      verify: (_) {
        verify(() => mockQuote.updateAmount('100')).called(1);
      },
    );
  });
}
```

---

## 迁移指南

如果从旧版 SwapCubit 迁移，请注意以下变化：

| 旧 API | 新 API |
|--------|--------|
| `state.selectedToken` | `state.fromToken` |
| `state.targetToken` | `state.toToken` |
| `state.status` (直接使用) | `state.swapStatus` |
| `swap()` 无参数 | `swap(BuildContext context)` |
| Toast 直接调用 | 通过 `SwapEvent` 事件 |

### 状态类型映射

```dart
// 旧状态
TradeStatusMessage.loading() -> SwapStatus.trading()
TradeStatusMessage.success() -> SwapStatus.success()
TradeStatusMessage.failure() -> SwapStatus.failure()

// 旧状态仍保留用于向后兼容
state.status // 旧版，已废弃
state.swapStatus // 新版，推荐使用
```
