# SwapCubit 快速参考

## 快速开始

### 1. 获取 Cubit

```dart
// 方式一：从 context 获取（推荐）
final swapCubit = context.read<SwapCubit>();

// 方式二：从 GetIt 获取
final swapCubit = getIt<SwapCubit>();
```

### 2. 常用操作

```dart
// 更新 Token
swapCubit.updateFromToken(fromToken);
swapCubit.updateToToken(toToken);

// 交换 Token
swapCubit.swapToken();

// 更新金额
swapCubit.updateAmount('100');
swapCubit.updateAmountToMax();

// 获取报价
swapCubit.getQuote();

// 执行交易
swapCubit.swap(context);

// 搜索 Token
swapCubit.searchTokens('SOL');
swapCubit.resetSearch();

// 生命周期
swapCubit.pauseTimers();
swapCubit.resumeTimers();
```

### 3. 状态监听

```dart
BlocBuilder<SwapCubit, SwapState>(
  builder: (context, state) {
    // 常用状态
    state.fromToken      // 源 Token
    state.toToken        // 目标 Token
    state.amount         // 金额
    state.fromBalance    // 余额
    state.quote          // 报价
    state.swapStatus     // 交易状态
    state.canTrade       // 是否可交易
    state.isTrading      // 是否交易中

    return YourWidget();
  },
)
```

### 4. 事件处理

```dart
BlocListener<SwapCubit, SwapState>(
  listenWhen: (prev, curr) => prev.event != curr.event,
  listener: (context, state) {
    final event = state.event;
    if (event == null) return;

    context.read<SwapCubit>().clearEvent();

    event.when(
      showLoading: () => showLoading(),
      hideLoading: () => hideLoading(),
      showParamsInvalid: () => showError('参数无效'),
      showError: (msg) => showError(msg),
      showSuccess: (msg, hash, symbol, amount, url) => showSuccess(),
      navigateToResult: (result) => navigateTo(result),
    );
  },
  child: YourWidget(),
)
```

## 状态类型

```dart
// 交易状态
SwapStatus.initial()           // 初始
SwapStatus.ready()             // 就绪
SwapStatus.trading()           // 交易中
SwapStatus.success(result)     // 成功
SwapStatus.failure(message)    // 失败

// 报价状态
QuoteStatus.initial()
QuoteStatus.loading()
QuoteStatus.success(quote)
QuoteStatus.failure()

// 余额状态
GetTokenBalanceStatus.initial()
GetTokenBalanceStatus.loading()
GetTokenBalanceStatus.success(balance)
GetTokenBalanceStatus.failure()
```

## 完整页面模板

```dart
class TradePage extends StatefulWidget {
  @override
  State<TradePage> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> with WidgetsBindingObserver {
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cubit = context.read<SwapCubit>();
    if (state == AppLifecycleState.paused) {
      cubit.pauseTimers();
    } else if (state == AppLifecycleState.resumed) {
      cubit.resumeTimers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwapCubit, SwapState>(
      listenWhen: (prev, curr) => prev.event != curr.event,
      listener: _handleEvent,
      child: BlocBuilder<SwapCubit, SwapState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                // 源 Token
                TokenCard(
                  token: state.fromToken,
                  balance: state.fromBalance,
                  onTap: () => _selectToken(isFrom: true),
                ),

                // 金额输入
                AmountInput(
                  value: state.amount,
                  onChanged: (v) => context.read<SwapCubit>().updateAmount(v),
                ),

                // 交换按钮
                IconButton(
                  icon: Icon(Icons.swap_vert),
                  onPressed: () => context.read<SwapCubit>().swapToken(),
                ),

                // 目标 Token
                TokenCard(
                  token: state.toToken,
                  amount: state.quote?.outAmount,
                  onTap: () => _selectToken(isFrom: false),
                ),

                // 报价信息
                if (state.quote != null)
                  QuoteInfo(quote: state.quote!),

                // 交易按钮
                ElevatedButton(
                  onPressed: state.canTrade && !state.isTrading
                      ? () => context.read<SwapCubit>().swap(context)
                      : null,
                  child: state.isTrading
                      ? CircularProgressIndicator()
                      : Text('Swap'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleEvent(BuildContext context, SwapState state) {
    final event = state.event;
    if (event == null) return;
    context.read<SwapCubit>().clearEvent();

    event.when(
      showLoading: () => showDialog(
        context: context,
        builder: (_) => LoadingDialog(),
      ),
      hideLoading: () => Navigator.pop(context),
      showParamsInvalid: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('请检查输入参数')),
      ),
      showError: (msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      ),
      showSuccess: (msg, hash, symbol, amount, url) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('交易成功: $amount $symbol')),
        );
      },
      navigateToResult: (result) {
        context.pushNamed('/result', extra: result);
      },
    );
  }

  void _selectToken({required bool isFrom}) {
    showModalBottomSheet(
      context: context,
      builder: (_) => TokenSelector(
        onSelect: (token) {
          if (isFrom) {
            context.read<SwapCubit>().updateFromToken(token);
          } else {
            context.read<SwapCubit>().updateToToken(token);
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}
```

## 架构图

```
┌──────────────────────────────────────────────┐
│                 TradePage                     │
│  BlocListener + BlocBuilder<SwapCubit>       │
└──────────────────────────────────────────────┘
                      │
                      ▼
┌──────────────────────────────────────────────┐
│               SwapCubit (协调器)              │
│  - 聚合子 Cubit 状态                          │
│  - 发出 SwapEvent                            │
└──────────────────────────────────────────────┘
         │              │              │
         ▼              ▼              ▼
┌────────────┐  ┌────────────┐  ┌────────────┐
│ TokenSel.  │  │   Quote    │  │Transaction │
│   Cubit    │  │   Cubit    │  │   Cubit    │
│ ────────── │  │ ────────── │  │ ────────── │
│ Token选择   │  │ 询价管理    │  │ 交易执行   │
│ 余额轮询    │  │ 定时刷新    │  │ 状态轮询   │
└────────────┘  └────────────┘  └────────────┘
```
