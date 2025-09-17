import "dart:async";

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_aigun/core/custom_exceptions.dart";
import "package:flutter_aigun/core/service_locator.dart";
import "package:flutter_aigun/cubits/index.dart";
import "package:flutter_aigun/data/models/transfer/index.dart";
import "package:flutter_aigun/data/services/api/index.dart";
import "package:flutter_aigun/enums/transaction.dart";
import "package:flutter_aigun/utils/extensions/string.dart";
import "package:flutter_aigun/utils/logger.dart";
import "package:flutter_aigun/utils/numeric_utils.dart";
import "package:flutter_aigun/utils/storage/local/wallet_storage.dart";
import "package:flutter_aigun/utils/toast.dart";
import "package:flutter_aigun/widgets/token/models/token.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class QuickTradeCubit extends Cubit<QuickTradeState> {
  late final StreamSubscription<BalanceState> _balanceCubitStream;
  QuickTradeCubit(this.tradeApi, this.tradeSettingCubit, this.walletStorage,
      this.balanceCubit)
      : super(const QuickTradeState()) {
    init();
  }

  Timer? _transactionStatusTimer;

  final TradeApi tradeApi;
  final TradeSettingCubit tradeSettingCubit;
  final WalletStorage walletStorage;

  final BalanceCubit balanceCubit;

  void updateFromToken(Token fromToken) {
    emit(state.copyWith(fromToken: fromToken));
  }

  void updateSelectedToken(Token toToken) {
    emit(state.copyWith(selectedToken: toToken));
    _onUpdateSelectedToken(toToken);
  }

  void updateMode(QuickTradeMode mode) {
    emit(state.copyWith(mode: mode));
  }

  void updateBuyAmount(String buyAmount) {
    emit(state.copyWith(buyAmount: buyAmount));
  }

  void updateSellPercent(String sellPercent) {
    emit(state.copyWith(sellPercent: sellPercent));
  }

  void _onUpdateSelectedToken(Token selectedToken) {
// TODO：选择代币数据所触发的函数，更新选择代币数据，后续使用接口进行搜索代币信息

    // 获取选中 token 的主笔
// 判断链 id 是否相等  address 则证明是主币
    final token = getIt<BalanceCubit>()
        .state
        .balances
        ?.tokens
        .firstWhere((token) => token.chainId == selectedToken.chainId);

    Logger.info("selectedToken: $selectedToken");

    if (token == null) {
      return;
    }

    updateFromToken(Token.fromBalance(token));
  }

  void init() {
    // 监听 balanceCubit，更新 selectedToken 的 balance 字段
    _balanceCubitStream = balanceCubit.stream.listen((balanceState) {
      // 异步处理，避免在 build 阶段触发状态更新
      Future.microtask(() async {
        final balance =
            await getBalanceByAddress(state.selectedToken?.address ?? "");

        // 只在 selectedToken 不为 null 时更新 balance 字段
        if (state.selectedToken != null) {
          final updatedToken = state.selectedToken!.copyWith(balance: balance);
          emit(state.copyWith(selectedToken: updatedToken));
        }
      });
    });
  }

  Future<void> buyToken(BuildContext context, VoidCallback closeToast,
      VoidCallback showTraingToast) async {
    if (state.buyTokenStatus == const BuyTokenStatus.loading()) {
      return;
    }

    emit(state.copyWith(buyTokenStatus: const BuyTokenStatus.loading()));

    if (state.fromToken == null || state.selectedToken == null) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);

      return;
    }

    if (state.fromToken?.address == state.selectedToken?.address) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);
      return;
    }

    if (state.fromToken?.chainId == null ||
        state.selectedToken?.chainId == null) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
      return;
    }

    try {
      showTraingToast();

      final settingOptions = tradeSettingCubit
          .getTradeCustomSettingByChainId(state.fromToken!.chainId);
      final newAmount = NumericUtils.multiplyByDecimalPower(
          state.buyAmount, state.fromToken!.decimals);
      final wallet = await walletStorage.getSelectedWallet();

      final response = await tradeApi.swap(
          fromChainId: state.fromToken!.chainId,
          toChainId: state.selectedToken!.chainId,
          inputMint: state.fromToken!.address,
          outputMint: state.selectedToken!.address,
          amount: newAmount.toString(),
          walletId: wallet?.id ?? "",
          options: settingOptions,
          mode: tradeSettingCubit.getTradeMode(),
          decimals: state.fromToken!.decimals);

      _transactionStatusTimer?.cancel();

// 在交易请求成功之后，轮询获取 交易的状态
      _transactionStatusTimer =
          Timer.periodic(const Duration(seconds: 2), (timer) {
        getTransactionStatus(response, state.fromToken!.chainId,
            newAmount.toString(), state.fromToken!.decimals, (result) {
          emit(state.copyWith(buyTokenStatus: BuyTokenStatus.success(result)));

          TradeStatusToastUtils.showSuccessToast(context,
              message: "交易成功",
              txHash: result.txHash ?? "",
              amount: newAmount.toString(),
              symbol: state.selectedToken?.symbol ?? "",
              txUrl: result.txUrl ?? "");
        }, () {
          emit(state.copyWith(
              buyTokenStatus:
                  const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
        });
      });
    } on DioException catch (e) {
      if (e.error is BusinessException) {
        emit(state.copyWith(
            buyTokenStatus:
                const BuyTokenStatus.failure(BuyTokenFailure.unknown)));

        TradeStatusToastUtils.showFailed(context);
      }
    } catch (e) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);
    } finally {
      emit(state.copyWith(buyTokenStatus: const BuyTokenStatus.initial()));
    }
  }

  Future<void> sellToken(BuildContext context, VoidCallback closeToast,
      VoidCallback showTraingToast) async {
    if (state.sellTokenStatus == const SellTokenStatus.loading()) {
      return;
    }

    emit(state.copyWith(sellTokenStatus: const SellTokenStatus.loading()));

    if (state.fromToken == null) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);
      return;
    }

    if (state.fromToken?.chainId == null) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);
      return;
    }

    if (state.fromToken?.address.isEmpty ?? true) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);
      return;
    }

    final sellAmount = NumericUtils.multiplyTwoNumbers(
        state.sellPercent.toPercentage(), state.selectedToken?.balance ?? "0");

    if (state.fromToken?.chainId == null) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);
      return;
    }

    try {
      showTraingToast();

      final wallet = await walletStorage.getSelectedWallet();
      final settingOptions = tradeSettingCubit
          .getTradeCustomSettingByChainId(state.fromToken!.chainId);

      // 转换为原生代币所以不需要目标代币的地址以及目标代币链 id 需要设置为 fromToken的链 id
      final response = await tradeApi.swap(
          fromChainId: state.fromToken!.chainId,
          toChainId: state.fromToken!.chainId,
          inputMint: state.selectedToken!.address,
          outputMint: "", //
          amount: NumericUtils.multiplyByDecimalPower(
                  sellAmount.toString(), state.fromToken!.decimals)
              .toString(),
          walletId: wallet?.id ?? "",
          options: settingOptions,
          mode: tradeSettingCubit.getTradeMode(),
          decimals: state.fromToken!.decimals);

      _transactionStatusTimer?.cancel();

      _transactionStatusTimer =
          Timer.periodic(const Duration(seconds: 2), (timer) {
        getTransactionStatus(response, state.fromToken!.chainId,
            sellAmount.toString(), state.fromToken!.decimals, (result) {
          emit(
              state.copyWith(sellTokenStatus: SellTokenStatus.success(result)));
          TradeStatusToastUtils.showSuccessToast(context,
              message: "交易成功",
              txHash: result.txHash ?? "",
              amount: sellAmount.toString(),
              symbol: state.fromToken?.symbol ?? "",
              txUrl: result.txUrl ?? "");
        }, () {
          emit(state.copyWith(
              sellTokenStatus:
                  const SellTokenStatus.failure(SellTokenFailure.unknown)));
        });
      });
    } on DioException catch (e) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));
      TradeStatusToastUtils.showFailed(context);
    } catch (e) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));
      TradeStatusToastUtils.showFailed(context);
    } finally {
      emit(state.copyWith(sellTokenStatus: const SellTokenStatus.initial()));
    }
  }

  Future<void> getTransactionStatus(
    TransferTransaction transaction,
    int chainId,
    String amount,
    int decimals,
    Function(TransferTransaction) success,
    VoidCallback failure,
  ) async {
    try {
      // 获取交易状态 传入交易hash 和链 id 获取交易状态
      final response = await getIt<WalletTransactionApi>().getTrasactionStatus(
          txHash: transaction.txHash ?? "", chainId: chainId.toString());

//  如果交易状态是成功
      if (response.status == TransactionStatusEnum.success.value) {
        success(transaction);
      } else if (response.status == TransactionStatusEnum.failed.value) {
        // 如果交易状态是失败
        failure();
      }

// 取消之前的定时器
      _transactionStatusTimer?.cancel();
    } catch (e) {
      // 取消之前的定时器
      _transactionStatusTimer?.cancel();
      failure();
    } finally {
      emit(state.copyWith(buyTokenStatus: const BuyTokenStatus.initial()));
      _transactionStatusTimer?.cancel();
    }
  }

  Future<String> getBalanceByAddress(String address) async {
    final balance =
        balanceCubit.getBalance(address, state.fromToken?.chainId ?? 0);

    return balance?.balance ?? "";
  }

  @override
  Future<void> close() {
    _balanceCubitStream.cancel();
    return super.close();
  }

  void clear() {
    emit(state.copyWith(
        fromToken: null,
        selectedToken: null,
        buyAmount: "",
        sellPercent: "",
        buyTokenStatus: const BuyTokenStatus.initial(),
        sellTokenStatus: const SellTokenStatus.initial()));
  }
}
