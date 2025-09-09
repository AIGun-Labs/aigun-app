import "package:flutter_aigun/cubits/index.dart";
import "package:flutter_aigun/cubits/quick_trade/quick_trade_state.dart";
import "package:flutter_aigun/data/services/api/index.dart";
import "package:flutter_aigun/utils/numeric_utils.dart";
import "package:flutter_aigun/utils/storage/local/wallet_storage.dart";
import "package:flutter_aigun/widgets/token/models/token.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class QuickTradeCubit extends Cubit<QuickTradeState> {
  QuickTradeCubit(this.tradeApi, this.tradeSettingCubit, this.walletStorage)
      : super(const QuickTradeState());

  final TradeApi tradeApi;
  final TradeSettingCubit tradeSettingCubit;
  final WalletStorage walletStorage;
  void updateFromToken(Token fromToken) {
    emit(state.copyWith(fromToken: fromToken));
  }

  void updateToToken(Token toToken) {
    emit(state.copyWith(toToken: toToken));
  }

  void updateBuyAmount(String buyAmount) {
    emit(state.copyWith(buyAmount: buyAmount));
  }

  void updateSellPercent(String sellPercent) {
    emit(state.copyWith(sellPercent: sellPercent));
  }

  Future<void> buyToken() async {
    emit(state.copyWith(buyTokenStatus: const BuyTokenStatus.loading()));

    if (state.fromToken == null || state.toToken == null) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
      return;
    }

    if (state.fromToken?.chainId == state.toToken?.chainId) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
      return;
    }

    if (state.fromToken?.address == state.toToken?.address) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
      return;
    }

    if (state.fromToken?.chainId == null || state.toToken?.chainId == null) {
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
          toChainId: state.toToken!.chainId,
          inputMint: state.fromToken!.address,
          outputMint: state.toToken!.address,
          amount: newAmount.toString(),
          walletId: wallet?.id ?? "",
          options: settingOptions,
          mode: tradeSettingCubit.getTradeMode(),
          decimals: state.fromToken!.decimals);

      emit(state.copyWith(buyTokenStatus: BuyTokenStatus.success(response)));
    } catch (e) {
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
    } catch (e) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));
    } finally {
      emit(state.copyWith(sellTokenStatus: const SellTokenStatus.initial()));
    }
  }
}
