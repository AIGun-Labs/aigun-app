import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/constant/count.dart';
import '../../core/router/constants.dart';
import '../../core/service_locator.dart';
import '../../data/models/transfer/transaction/transaction.dart';
import '../../data/services/api/index.dart';
import '../../data/services/api/token_api.dart';
import '../../data/services/sentry_service.dart';
import '../../enums/trade_mode.dart';
import '../../enums/transaction.dart';
import '../../l10n/l10n.dart';
import '../../shared/trade/trade_button_state.dart';
import '../../utils/debouncer.dart';
import '../../utils/decimal.dart';
import '../../utils/error_handler_utils.dart';
import '../../utils/extensions/string.dart';
import '../../utils/format/currency.dart';
import '../../utils/logger.dart';
import '../../utils/numeric_utils.dart';
import '../../utils/storage/local/token_swap_storage.dart';
import '../../utils/storage/local/wallet_storage.dart';
import '../../utils/toast/trade_status_toast.dart';
import '../../utils/validators/token_validator.dart';
import '../../utils/validators/trade_validator.dart';
import '../../widgets/token/models/token.dart';
import '../index.dart' hide QuoteStatus;
import 'trade_state.dart';

class TradeCubit extends Cubit<TradeState> {
  StreamSubscription? _balanceCubitStream;
  final BalanceCubit balanceCubit;
  final TradeSettingCubit tradeSettingCubit;
  Timer? _quoteTimer;
  TradeApi tradeApi;
  WalletStorage walletStorage;
  final TokenApi tokenApi;
  Timer? _transactionStatusTimer;
  Timer? _balanceTimer;
  TradeCubit(
    this.balanceCubit,
    this.tradeSettingCubit,
    this.tokenApi,
    this.tradeApi,
    this.walletStorage,
  ) : super(const TradeState()) {
    init(); //初始化代币列表

    // 监听balanceCubit，更新availableTokens
    _balanceCubitStream = balanceCubit.stream.listen((balanceCubitState) async {
      final availableTokens = balanceCubitState.balances?.tokens
          .map(
            (token) => Token(
              chainId: token.chainId,
              chainLogo: token.chainLogo,
              tokenAvatar: token.tokenAvatar,
              tokenName: token.tokenName,
              tokenPrice: token.tokenPrice,
              rawBalance: token.balance,
              balance: token.balance,
              decimals: token.decimals,
              symbol: token.symbol,
              chainName: token.chainName,
              slug: token.network,
              network: token.network,
              // tokenPrice: token.tokenPrice,
              isNative: token.isNative,
              address: token.tokenAddress,
            ),
          )
          .toList();

      emit(state.copyWith(availableTokens: availableTokens ?? []));

      // 更新fromToken
      final tokens = balanceCubit.state.balances?.tokens;

      // 虽然默认设置了fromToken，但是这里最好还是从用户钱包里面拿
      if (tokens == null || tokens.isEmpty) {
        // 默认选择 SOL 交易对
        final solToken = tokens
            ?.where(
              (token) =>
                  token.tokenAvatar.isNotEmpty &&
                  token.symbol.toLowerCase() == 'sol',
            )
            .firstOrNull;

        // 如果用户钱包里面的 sol 不为空
        if (solToken != null) {
          // 检查 SOL token 的余额是否为 0
          final shouldUseDefault = !(solToken.balance.isNotEmptyAndZeroValue);
          // 从本地中获取 fromToken
          final fromToken = await getIt<TokenSwapStorage>().getFromToken();

          if (shouldUseDefault) {
            // 如果余额为 0，使用默认的 SOL token
            // emit(state.copyWith(fromToken: defaultFormTradeToken));
            if (fromToken != null) {
              emit(state.copyWith(fromToken: TradeToken.fromToken(fromToken)));
            }
          } else {
            // 如果余额不为 0，使用从钱包中获取的 SOL token
            emit(
              state.copyWith(
                fromToken: TradeToken(
                  isNative: solToken.isNative,
                  chainId: solToken.chainId,
                  chainLogo: solToken.chainLogo,
                  tokenAvatar: solToken.tokenAvatar,
                  tokenName: solToken.symbol,
                  symbol: solToken.symbol,
                  balance: solToken.balance,
                  decimals: solToken.decimals,
                  chainName: solToken.chainName,
                  address: solToken.tokenAddress,
                  network: solToken.network,
                  tokenPrice: double.tryParse(solToken.tokenPrice) ?? 0,
                ),
              ),
            );
          }
        }
      }
    });
  }

  void resetAll() {
    emit(
      state.copyWith(
        status: const TradeStatusMessage.initial(),
        quoteStatus: const QuoteStatus.initial(),
        fromBalanceStatus: const GetTokenBalanceStatus.initial(),
      ),
    );
  }

  // 询价防抖器
  final Debouncer _quoteDebouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  final Debouncer _getFormBalance = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  /// 检查两个代币是否应该交换（地址和 network 相同）
  bool _shouldSwapTokens(TradeToken newToken, TradeToken? compareToken) {
    return compareToken != null &&
        newToken.address == compareToken.address &&
        newToken.network == compareToken.network;
  }

  /// 交换 from 和 to 代币
  void _swapTokens({
    required TradeToken newToken,
    required TradeToken? previousToken,
    required bool isUpdatingFrom,
  }) {
    if (isUpdatingFrom) {
      // 更新 fromToken，将之前的 fromToken 设置为 toToken
      emit(state.copyWith(fromToken: newToken, toToken: previousToken));
      // 保存交换后的代币到本地存储
      if (previousToken != null) {
        getIt<TokenSwapStorage>().saveToToken(
          Token.fromTradeToken(previousToken),
        );
      }
    } else {
      // 更新 toToken，将之前的 toToken 设置为 fromToken
      emit(state.copyWith(toToken: newToken, fromToken: previousToken));
      // 保存交换后的代币到本地存储
      if (previousToken != null) {
        getIt<TokenSwapStorage>().saveFromToken(
          Token.fromTradeToken(previousToken),
        );
      }
      // 更新交易设置链名称和余额
      updateTradeSettingChainName();
      getBalanceSelectedToken();
    }
  }

  void updateFromToken(TradeToken fromToken) {
    // 检查新选择的 fromToken 是否与当前 toToken 的地址和 network 相同
    final shouldSwap = _shouldSwapTokens(fromToken, state.toToken);

    if (shouldSwap) {
      // 如果相同，交换 from 和 to：from 更新为新选择的代币，to 更新为之前的 from
      _swapTokens(
        newToken: fromToken,
        previousToken: state.fromToken,
        isUpdatingFrom: true,
      );
    } else {
      // 如果不同，正常更新 fromToken
      emit(state.copyWith(fromToken: fromToken));
    }

    getIt<TokenSwapStorage>().saveFromToken(
      Token.fromTradeToken(fromToken),
    ); // save to storage 中
    updateTradeSettingChainName(); // 更新一次就获取一次余额
    getBalanceSelectedToken();
    // 获取最新实时平均数据
    tradeSettingCubit.getTradeLiveData();

    // 更新 fromToken 后询价
    _quoteDebouncer.run(() {
      getQuote();
    });
  }

  void updateTradeSettingChainName() {
    final network = state.fromToken?.network ?? '';

    tradeSettingCubit.updateNetwork(network);
  }

  void toReceivePage(BuildContext context, TradeToken? token) {
    if (token == null) {
      return;
    }
    final walletAddress = getIt<WalletCubit>().getWalletByNetwork(
      token.network ?? '',
    );

    // 为 null 就是不支持
    if (walletAddress == null) {
      return;
    }
    // final chainLogo = getIt<BalanceCubit>()
    //     .getChainLogoByAddress(token.address, token.chainId);

    final title = S.of(context).networkReceive(token.chainName);

    context.pushNamed(
      RouteNames.receiveAddress,
      extra: {
        'avatar': walletAddress.chainLogo,
        'title': title,
        'symbol': walletAddress.chainName,
        'address': walletAddress.address,
        // "subAvatar": token.chainLogo,
      },
    );
  }

  void updateToToken(TradeToken toToken) {
    // 检查新选择的 toToken 是否与当前 fromToken 的地址和 network 相同
    final shouldSwap = _shouldSwapTokens(toToken, state.fromToken);

    if (shouldSwap) {
      // 如果相同，交换 from 和 to：to 更新为新选择的代币，from 更新为之前的 to
      _swapTokens(
        newToken: toToken,
        previousToken: state.toToken,
        isUpdatingFrom: false,
      );
    } else {
      // 如果不同，正常更新 toToken
      emit(state.copyWith(toToken: toToken));
    }

    emit(state.copyWith(quote: null));

    getIt<TokenSwapStorage>().saveToToken(
      Token.fromTradeToken(toToken),
    ); // save to storage 中

    // 更新 token 后询价
    _quoteDebouncer.run(() {
      getQuote();
    });
  }

  void updateSlippage(String slippage) {
    emit(state.copyWith(slippage: int.parse(slippage)));
  }

  void updatePriorityFee(String priorityFee) {
    emit(state.copyWith(priorityFee: int.parse(priorityFee)));
  }

  void updateAmount(String amount) {
    if (!amount.isNotEmptyAndZeroValue) {
      emit(state.copyWith(quote: null));
    }

    emit(state.copyWith(amount: amount));

    // 更新 amount 后询价
    _quoteDebouncer.run(() {
      getQuote();
    });
  }

  void _startQuoteTimer() {
    _quoteTimer?.cancel();
    if (state.lastQuoteTimestamp != null) {
      // 获取上次询价到现在的间<隔时间
      final elapsed = DateTime.now().difference(state.lastQuoteTimestamp!);
      // 使用10秒减去间隔时间，得到剩余时间
      final remainingSeconds =
          Duration(seconds: NumericConstants.ten).inSeconds - elapsed.inSeconds;

      // 如果剩余时间大于0
      if (remainingSeconds > 0) {
        // 那么根据剩余实现设置倒计时
        _quoteTimer = Timer(Duration(seconds: remainingSeconds), () {
          getQuote();
          // 剩余时间结束后开始新一轮询价
          _quoteTimer = Timer.periodic(
            Duration(seconds: NumericConstants.ten),
            (timer) {
              getQuote();
            },
          );
        });
      } else {
        _quoteTimer = Timer.periodic(Duration(seconds: NumericConstants.ten), (
          timer,
        ) {
          getQuote();
        });
      }
    } else {
      _quoteTimer = Timer(Duration(seconds: NumericConstants.ten), () {
        getQuote();

        _quoteTimer = Timer.periodic(Duration(seconds: NumericConstants.ten), (
          timer,
        ) {
          getQuote();
        });
      });
    }
  }

  //  更新询价的时间戳
  void _updateQuoteTimestamp() {
    emit(state.copyWith(lastQuoteTimestamp: DateTime.now()));
    _startQuoteTimer(); // 重新开始询价定时器
  }

  // 更新 amount 为最大值的 99.5%
  void updateAmountToMax() {
    final balance = state.fromBalance.toString();

    if (!(balance.isNotEmptyAndZeroValue)) {
      emit(state.copyWith(amount: '0'));
    }
    if (state.fromToken?.isNative ?? false) {
      final maxAmount = NumericUtils.multiplyTwoNumbers(balance, 0.995);
      final maxAmountString = maxAmount.toString();

      updateAmount(maxAmountString);
    } else {
      updateAmount(balance);
      emit(state.copyWith(fromBalance: double.tryParse(balance) ?? 0));
    }

    // 格式化为四位小数，移除末尾的0
  }

  bool checkAmount(String amount, String balance) {
    final amountValue = double.tryParse(amount) ?? 0.0;
    final balanceValue = double.tryParse(balance) ?? 0.0;

    if (amountValue <= balanceValue) {
      return true;
    }

    return false;
  }

  Future<void> init() async {
    await getNativeTokens(); // init native tokens
    _balanceTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getBalanceSelectedToken();
    });

    final tokens = await getIt<TokenSwapStorage>().getTokens();
    emit(
      state.copyWith(
        fromToken: TradeToken.fromToken(tokens[0]!),
        toToken: TradeToken.fromToken(tokens[1]!),
      ),
    );
  }

  Future<void> getNativeTokens() async {
    try {
      final nativeTokens = await tokenApi.getNativeTokens();
      emit(state.copyWith(nativeTokens: nativeTokens));
    } catch (e, s) {
      emit(
        state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.none),
        ),
      );

      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getNativeTokens'},
      );
    }
  }

  Future<void> searchTokens(String keyword) async {
    try {
      final walletId = getIt<WalletCubit>().state.wallets.first.id;

      final tokens = await tokenApi.searchTokens(keyword, walletId);
      emit(state.copyWith(nativeTokens: tokens));
    } catch (e, s) {
      emit(
        state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.none),
        ),
      );
      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'searchTokens'},
        extra: {'keyword': keyword},
      );
    }
  }

  // transfer
  // ignore: use_build_context_synchronously
  Future<void> swap(BuildContext context) async {
    TradeStatusToastUtils.dismissToast();
    if (TradeValidator.isChainIdEmpty(
      state.fromToken?.chainId ?? '',
      state.toToken?.chainId ?? '',
    )) {
      Logger.error(
        'swap chainId empty: ${state.fromToken?.chainId} ${state.toToken?.chainId}',
      );
      emit(
        state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.paramsInvalid),
        ),
      );
      TradeStatusToastUtils.showParamsInvalidToast();
      return;
    }

    if (!(state.fromBalance.toString().isNotEmptyAndZeroValue)) {
      Logger.error('swap balance empty: ${state.fromBalance}');
      emit(
        state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.paramsInvalid),
        ),
      );
      TradeStatusToastUtils.showParamsInvalidToast();
      return;
    }

    if (TradeValidator.equalsToken(
      state.fromToken?.unique ?? '',
      state.toToken?.unique ?? '',
      state.fromToken?.address ?? '',
      state.toToken?.address ?? '',
    )) {
      emit(state.copyWith(paramsStatus: const TradeParamsStatus.failure()));
      return;
    }

    if (state.amount.isEmpty) {
      Logger.error('swap amount empty: ${state.amount}');
      emit(
        state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.paramsInvalid),
        ),
      );
      TradeStatusToastUtils.showParamsInvalidToast();
      return;
    }

    try {
      TradeStatusToastUtils.showTrainingToast();

      final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();
      final newAmount = NumericUtils.multiplyByDecimalPower(
        state.amount,
        state.fromToken!.decimals,
      ).toString();

      if (!newAmount.isNotEmptyAndZeroValue) {
        TradeStatusToastUtils.dismissToast();
        emit(
          state.copyWith(
            status: const TradeStatusMessage.failure(TradeStatus.paramsInvalid),
          ),
        );
        TradeStatusToastUtils.showParamsInvalidToast();
        return;
      }
      // get user default wallet
      final wallet = await walletStorage.getSelectedWallet();

      emit(state.copyWith(status: const TradeStatusMessage.loading()));

      if (wallet == null) {
        Logger.error('swap wallet empty: ${wallet?.id}');
        emit(
          state.copyWith(
            status: const TradeStatusMessage.failure(TradeStatus.none),
          ),
        );
        TradeStatusToastUtils.showParamsInvalidToast();
        return;
      }

      final response = await tradeApi.swap(
        network: state.fromToken?.network ?? '',
        amount: newAmount,
        fromChainId: state.fromToken?.unique ?? '',
        toChainId: state.toToken?.unique ?? '',
        inputMint: state.fromToken?.address ?? '',
        outputMint: state.toToken?.address ?? '',
        walletId: wallet.id ?? '',
        options: settingOptions,
        mode: tradeSettingCubit.getTradeMode(),
        decimals: state.fromToken!.decimals,
      );

      // 先取消之前的定时器
      _transactionStatusTimer?.cancel();

      // 设置新的定时器
      _transactionStatusTimer = Timer.periodic(const Duration(seconds: 2), (
        timer,
      ) {
        getTransactionStatus(response, context);
      });
    } catch (e, s) {
      TradeStatusToastUtils.dismissToast();
      // ignore: use_build_context_synchronously
      final errorMessage = ErrorHandlerUtils.getErrorMessageFromException(
        e,
        context,
      );
      TradeStatusToastUtils.showFailedToast(message: errorMessage);

      final newAmount = NumericUtils.multiplyByDecimalPower(
        state.amount,
        state.fromToken!.decimals,
      ).toString();

      final wallet = await walletStorage.getSelectedWallet();
      emit(
        state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.none),
        ),
      );
      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'swap'},
        extra: {
          'amount': newAmount,
          'fromChainId': state.fromToken?.unique ?? '',
          'toChainId': state.toToken?.unique ?? '',
          'inputMint': state.fromToken?.address ?? '',
          'outputMint': state.toToken?.address ?? '',
          'walletId': double.tryParse(wallet?.id ?? '0') ?? 0,
          'options': tradeSettingCubit.getCurrentTradeCustomSetting(),
          'mode': tradeSettingCubit.getTradeMode(),
          'decimals': state.fromToken!.decimals,
        },
      );
    }
  }

  Future<void> getTransactionStatus(
    TransferTransaction transaction,
    BuildContext context,
  ) async {
    try {
      // 获取交易状态 传入交易hash 和链 id 获取交易状态
      final response = await getIt<WalletTransactionApi>().getTrasactionStatus(
        txHash: transaction.txHash ?? '',
        chainId: state.fromToken?.chainId ?? '',
        network: state.fromToken!.network ?? '',
      );

      //  如果交易状态是成功
      if (response.status == TransactionStatusEnum.success.value) {
        Logger.error('getTransactionStatus success: ${response.status}');
        emit(
          state.copyWith(
            status: TradeStatusMessage.success(transaction),
            paramsStatus: const TradeParamsStatus.initial(),
          ),
        );

        final newAmount = NumericUtils.convertFromAtomicUnits(
          state.quote?.outAmount ?? '',
          state.toToken?.decimals ?? 18,
        );
        // 交易成功
        TradeStatusToastUtils.dismissToast();
        TradeStatusToastUtils.showSuccessToast(
          message: S.of(context).transactionSuccess,
          txHash: transaction.txHash ?? '',
          symbol: state.toToken?.symbol ?? '',
          amount: CurrencyFormatter.abbreviateTokenPrice(
            double.tryParse(newAmount) ?? 0,
          ),
          txUrl: transaction.txUrl,
        );

        getBalanceSelectedToken();

        // 关闭
        _transactionStatusTimer?.cancel();
      } else if (response.status == TransactionStatusEnum.failed.value) {
        Logger.error('getTransactionStatus failed: ${response.status}');
        // 如果交易状态是失败
        emit(
          state.copyWith(
            status: const TradeStatusMessage.failure(TradeStatus.none),
            paramsStatus: const TradeParamsStatus.initial(),
          ),
        );

        TradeStatusToastUtils.dismissToast();
        TradeStatusToastUtils.showFailedToast();

        _transactionStatusTimer?.cancel();

        await SentryService().reportError(
          'The transaction request was successful, but the status failed',
          StackTrace.fromString(''),
          tags: {'feature': 'getTransactionStatus'},
          extra: {
            'txHash': transaction.txHash,
            'chainId': state.fromToken?.chainId ?? '',
          },
        );
      } else {
        Logger.error('getTransactionStatus: ${response.status}');
      }
    } catch (e, s) {
      TradeStatusToastUtils.dismissToast();
      // 取消之前的定时器
      _transactionStatusTimer?.cancel();
      emit(
        state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.none),
        ),
      );
      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getTransactionStatus'},
        extra: {
          'txHash': transaction.txHash ?? '',
          'chainId': state.fromToken?.chainId ?? '',
        },
      );
    }
  }

  Future<void> swapToken() async {
    final currentFromToken = state.fromToken;
    final currentToToken = state.toToken;
    final currentToAmount =
        state.quote?.outAmount.toString().divideByDecimalPower(
          state.toToken?.decimals ?? 18,
        ) ??
        '';

    // 新增：若没有有效报价，回退为原 amount
    final nextAmount = (currentToAmount.isNotEmpty)
        ? currentToAmount
        : state.amount;

    // 更新交易设置选中的网络
    await getIt<TradeSettingCubit>().updateNetwork(
      currentToToken?.network ?? '',
    );

    // 更新状态
    emit(
      state.copyWith(
        fromToken: currentToToken,
        toToken: currentFromToken,
        fromBalance: null,
        quote: null,
        quoteStatus: const QuoteStatus.initial(),
        amount: nextAmount, // 使用回退后的值
      ),
    );

    if (currentFromToken != null) {
      await getBalanceSelectedToken();
      await getQuote();
    }
  }

  Future<void> getBalanceSelectedToken() async {
    final selectedToken = state.fromToken;

    if (selectedToken?.chainId == null || selectedToken?.address == null) {
      return;
    }

    final wallets = getIt<WalletCubit>().state.wallets;
    if (wallets.isEmpty) {
      return;
    }

    final walletId = wallets.first.id;
    try {
      final tokens = getIt<BalanceCubit>().state.balances?.tokens;

      final tokenBalance = tokens
          ?.where(
            (balance) =>
                balance.tokenAddress == selectedToken?.address &&
                balance.chainId == selectedToken?.chainId,
          )
          .firstOrNull;

      final newBalance = double.tryParse(tokenBalance?.balance ?? '0') ?? 0;

      // 只有当余额真正发生变化时才更新状态
      if (state.fromBalance != newBalance) {
        Timer(const Duration(milliseconds: 200), () {
          emit(
            state.copyWith(
              fromBalance: newBalance,
              fromBalanceStatus: GetTokenBalanceStatus.success(
                tokenBalance?.balance ?? '',
              ),
            ),
          );
        });
      } else {
        // 余额没变，只更新状态
        emit(
          state.copyWith(
            fromBalanceStatus: GetTokenBalanceStatus.success(
              tokenBalance?.balance ?? '',
            ),
          ),
        );
      }
    } catch (e, s) {
      emit(
        state.copyWith(
          fromBalanceStatus: const GetTokenBalanceStatus.failure(),
        ),
      );
      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getBalanceSelectedToken'},
        extra: {
          'walletId': walletId,
          'address': selectedToken?.address.toString(),
          'chainId': selectedToken?.chainId,
        },
      );
    }
  }

  Future<void> getQuote() async {
    if (TradeValidator.isChainIdEmpty(
      state.fromToken?.unique ?? '',
      state.toToken?.unique ?? '',
    )) {
      emit(state.copyWith(paramsStatus: const TradeParamsStatus.failure()));
      return;
    }

    if (TradeValidator.equalsToken(
      state.fromToken?.unique ?? '',
      state.toToken?.unique ?? '',
      state.fromToken?.address ?? '',
      state.toToken?.address ?? '',
    )) {
      emit(state.copyWith(paramsStatus: const TradeParamsStatus.failure()));
      return;
    }

    final newAmount = multiplyByDecimalPower(
      state.amount,
      state.fromToken!.decimals,
    ).toString();

    if (!(newAmount.isNotEmptyAndZeroValue)) {
      emit(state.copyWith(paramsStatus: const TradeParamsStatus.failure()));
      return;
    }
    try {
      emit(state.copyWith(quoteStatus: const QuoteStatus.loading()));
      final setting = tradeSettingCubit.getCurrentTradeCustomSetting();
      // get trade quote
      final response = await tradeApi.getQuote(
        network: state.fromToken!.network ?? '',
        fromChainId: state.fromToken?.unique ?? '',
        toChainId: state.toToken?.unique ?? '',
        inputMint: state.fromToken?.address ?? '',
        outputMint: state.toToken?.address ?? '',
        amount: newAmount,
        mode: setting.mode ?? TradeMode.fast,
        options: setting,
        decimals: state.fromToken!.decimals,
      );

      emit(
        state.copyWith(
          quoteStatus: QuoteStatus.success(response),
          quote: response,
          paramsStatus: const TradeParamsStatus.success(),
        ),
      );
      // 更新询价时间戳
      _updateQuoteTimestamp();
    } catch (e, s) {
      Logger.info('getQuote error: $e');
      emit(
        state.copyWith(
          quoteStatus: const QuoteStatus.failure(),
          paramsStatus: const TradeParamsStatus.failure(),
        ),
      );
      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getQuote'},
        extra: {
          'fromChainId': state.fromToken?.chainId ?? '',
          'toChainId': state.toToken?.chainId ?? '',
          'inputMint': state.fromToken?.address ?? '',
          'outputMint': state.toToken?.address ?? '',
          'amount': newAmount,
        },
      );
    }
  }

  void clear() {
    emit(
      state.copyWith(
        quoteStatus: const QuoteStatus.initial(),
        quote: null,
        amount: '',
        fromBalance: null,
      ),
    );
  }

  @override
  Future<void> close() {
    _quoteTimer?.cancel();
    _balanceCubitStream?.cancel();
    state.amountController?.dispose();
    _quoteDebouncer.dispose();
    _balanceTimer?.cancel();
    _transactionStatusTimer?.cancel();

    return super.close();
  }

  // 暂停所有定时器
  void pauseTimers() {
    _quoteTimer?.cancel();
    _balanceTimer?.cancel();
    _transactionStatusTimer?.cancel();
  }

  // 恢复定时器（在页面重新激活时使用）
  void resumeTimers() {
    // 重启余额查询定时器
    _balanceTimer?.cancel();
    _balanceTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getBalanceSelectedToken();
    });

    // 重启询价定时器
    if (state.amount.isNotEmpty &&
        state.fromToken != null &&
        state.toToken != null) {
      _startQuoteTimer();
    }
  }

  void cancelTransactionStatusTimer() {
    _transactionStatusTimer?.cancel();
  }

  bool isEnoughFee() {
    final fee = state.quote?.fee?.toDouble() ?? 0.0;

    if (state.fromToken == null) return false;

    // 如果是原生代币，直接检查余额
    if (state.fromToken!.isNative) {
      final balance = NumericUtils.multiplyByDecimalPower(
        state.fromBalance.toString(),
        state.fromToken!.decimals,
      ).toString();

      final remainingBalance = balance.toDouble() - fee;
      return remainingBalance >= 0;
    }

    // 如果是非原生代币，查找并检查原生代币余额
    final nativeToken = _getNativeToken(state.fromToken!.network);
    if (nativeToken == null) {
      Logger.error('Native token not found for ${state.fromToken!.network}');
      return false;
    }

    final nativeBalance = NumericUtils.multiplyByDecimalPower(
      nativeToken.balance,
      nativeToken.decimals,
    ).toString();

    final remainingBalance = nativeBalance.toDouble() - fee;

    Logger.info('Native balance check for fee: $remainingBalance (Fee: $fee)');

    return remainingBalance >= 0;
  }

  Token? _getNativeToken(String? network) {
    if (network == null) return null;
    final tokens = balanceCubit.state.balances?.tokens ?? [];

    try {
      final match = tokens.firstWhere(
        (t) =>
            t.network.toLowerCase() == network.toLowerCase() &&
            TokenValidator.isNativeToken(t.tokenAddress, network: t.network),
      );
      return Token.fromBalance(match);
    } catch (e) {
      return null;
    }
  }

  /// Get complete button state including fee validation
  /// This is the single source of truth for the trade button UI
  TradeButtonState get buttonState {
    // Get base state from TradeState extension
    final baseState = state.baseButtonState;

    // If already trading, quoteLoading, or ready (no disabled reasons), return as-is
    if (baseState is! TradeButtonDisabled) {
      return baseState;
    }

    // If there's already a high-priority error, return it
    final disabledState = baseState as TradeButtonDisabled;
    if (disabledState.reason.priority > 5) {
      return baseState;
    }

    // Check fee validation (only when we have a valid quote and amount)
    final hasValidQuote = state.quoteStatus.maybeWhen(
      success: (_) => state.quote != null,
      orElse: () => false,
    );

    if (hasValidQuote && state.amount.isNotEmptyAndZeroValue) {
      if (!isEnoughFee()) {
        return const TradeButtonState.disabled(
          reason: TradeButtonDisabledReason.insufficientFee(),
        );
      }
    }

    return baseState;
  }
}
