import "dart:async";

import "package:dio/dio.dart";
import "package:flutter_aigun/core/custom_exceptions.dart";
import "package:flutter_aigun/cubits/index.dart";
import "package:flutter_aigun/cubits/quick_trade/quick_trade_state.dart";
import "package:flutter_aigun/data/services/api/index.dart";
import "package:flutter_aigun/utils/numeric_utils.dart";
import "package:flutter_aigun/utils/storage/local/wallet_storage.dart";
import "package:flutter_aigun/widgets/toast.dart";
import "package:flutter_aigun/widgets/token/models/token.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:toastification/toastification.dart";

class QuickTradeCubit extends Cubit<QuickTradeState> {
  late final StreamSubscription<BalanceState> _balanceCubitStream;
  QuickTradeCubit(this.tradeApi, this.tradeSettingCubit, this.walletStorage,
      this.balanceCubit)
      : super(const QuickTradeState()) {
    init();
  }

  final TradeApi tradeApi;
  final TradeSettingCubit tradeSettingCubit;
  final WalletStorage walletStorage;

  final BalanceCubit balanceCubit;

  void updateFromToken(Token fromToken) {
    emit(state.copyWith(fromToken: fromToken));
  }

  void updateSelectedToken(Token toToken) {
    emit(state.copyWith(selectedToken: toToken));
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

  void init() {
    // 监听 balanceCubit，更新 selectedToken 的 balance 字段
    _balanceCubitStream = balanceCubit.stream.listen((balanceState) async {
      final balance =
          await getBalanceByAddress(state.selectedToken?.address ?? "");

      // 只在 selectedToken 不为 null 时更新 balance 字段
      if (state.selectedToken != null) {
        final updatedToken = state.selectedToken!.copyWith(balance: balance);
        emit(state.copyWith(selectedToken: updatedToken));
      }
    });
  }

  Future<void> buyToken() async {
    emit(state.copyWith(buyTokenStatus: const BuyTokenStatus.loading()));

    if (state.fromToken == null || state.selectedToken == null) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
      return;
    }

    if (state.fromToken?.chainId == state.selectedToken?.chainId) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
      return;
    }

    if (state.fromToken?.address == state.selectedToken?.address) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
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

      emit(state.copyWith(buyTokenStatus: BuyTokenStatus.success(response)));
    } on DioException catch (e) {
      if (e.error is BusinessException) {
        // Business Exception handling
        BusinessException be = e.error as BusinessException;
        showSimpleToast("错误：${be.msg} 状态码：${be.code}",
            type: ToastificationType.error);
      }
    } catch (e) {
      showSimpleToast(e.toString(), type: ToastificationType.error);
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
    } finally {
      emit(state.copyWith(buyTokenStatus: const BuyTokenStatus.initial()));
    }
  }

  Future<void> sellToken() async {
    emit(state.copyWith(sellTokenStatus: const SellTokenStatus.loading()));

    if (state.fromToken == null) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));
      return;
    }

    if (state.fromToken?.chainId == null) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));
      return;
    }

    if (state.fromToken?.address.isEmpty ?? true) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));
      return;
    }

    if (state.fromToken?.chainId == null) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));
      return;
    }

    try {
      final wallet = await walletStorage.getSelectedWallet();
      final settingOptions = tradeSettingCubit
          .getTradeCustomSettingByChainId(state.fromToken!.chainId);

      // 转换为原生代币所以不需要目标代币的地址以及目标代币链 id 需要设置为 fromToken的链 id
      final response = await tradeApi.swap(
          fromChainId: state.fromToken!.chainId,
          toChainId: state.fromToken!.chainId,
          inputMint: state.fromToken!.address,
          outputMint: "", //
          amount: state.buyAmount,
          walletId: wallet?.id ?? "",
          options: settingOptions,
          mode: tradeSettingCubit.getTradeMode(),
          decimals: state.fromToken!.decimals);

      emit(state.copyWith(sellTokenStatus: SellTokenStatus.success(response)));
    } on DioException catch (e) {
      if (e.error is BusinessException) {
        // Business Exception handling
        BusinessException be = e.error as BusinessException;
        showSimpleToast("错误：${be.msg} 状态码：${be.code}",
            type: ToastificationType.error);
      }
    } catch (e) {
      showSimpleToast(e.toString(), type: ToastificationType.error);
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));
    } finally {
      emit(state.copyWith(sellTokenStatus: const SellTokenStatus.initial()));
    }
  }

  Future<String> getBalanceByAddress(String address) async {
    final balance =
        await balanceCubit.getBalance(address, state.fromToken?.chainId ?? 0);

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
