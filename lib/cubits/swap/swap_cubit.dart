import 'dart:async';
import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../../data/models/index.dart';
import '../../data/models/swap/target_token/target_token.dart';
import '../../data/models/wallet/token/token.dart';
import '../../data/services/api/wallet_transaction.dart';
import '../../data/services/sentry_service.dart';
import '../../utils/decimal.dart';
import '../../utils/validators/address_validator.dart';
import '../index.dart';

class SwapCubit extends Cubit<SwapState> {
  Timer? _quoteTimer;

  final WalletCubit _walletCubit = getIt<WalletCubit>();
  final WalletTransactionApi _walletTransactionApi =
      getIt<WalletTransactionApi>();

  SwapCubit() : super(SwapState.initial()) {
    _quoteTimer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      getQuote();
    });
  }
  @override
  Future<void> close() {
    _quoteTimer?.cancel();
    return super.close();
  }

  void updateFromChainId(int fromChainId) {
    emit(state.copyWith(fromChainId: fromChainId));
  }

  void updateToken(Token token) {
    emit(state.copyWith(selectedToken: token));
  }

  void updateToChainId(String toChainId) {
    emit(state.copyWith(toChainId: toChainId));
  }

  void updateInputMint(String inputMint) {
    emit(state.copyWith(inputMint: inputMint.toString()));
  }

  void updateOutputMint(String outputMint) {
    emit(state.copyWith(outputMint: outputMint.toString()));
  }

  void updateAmount(String amount) {
    emit(state.copyWith(amount: amount));
  }

  void updateSelectedChain(Chain chain) {
    emit(state.copyWith(selectedChain: chain));
  }

  void updateTargetToken(TargetToken toToken) {
    emit(state.copyWith(toToken: toToken));
  }

  void updateSlippage(double slippage) {
    emit(state.copyWith(slippage: slippage));
  }

  void updatePriorityFee(String priorityFee) {
    emit(state.copyWith(priorityFee: priorityFee));
  }

  Future<void> swap({
    required String fromChainId,
    required String toChainId,
    required String inputMint,
    required String outputMint,
    required String amount,
    required String slippage,
    required String priorityFee,
    // required String paymentPin
  }) async {
    if (state.selectedToken == null) {
      emit(
        state.copyWith(transactionStatus: const TransactionStatus.error("")),
      );
      return;
    }

    if (state.amount.isEmpty) {
      emit(
        state.copyWith(transactionStatus: const TransactionStatus.error("")),
      );
      return;
    }

    if (state.outputMint.isEmpty) {
      emit(
        state.copyWith(transactionStatus: const TransactionStatus.error("")),
      );
      return;
    }

    if (state.fromChainId == int.tryParse(state.toChainId)) {
      emit(
        state.copyWith(transactionStatus: const TransactionStatus.error("")),
      );
      return;
    }

    if (state.selectedToken!.tokenAddress == state.outputMint &&
        state.selectedToken!.tokenAddress.isNotEmpty) {
      emit(
        state.copyWith(transactionStatus: const TransactionStatus.error("")),
      );
      return;
    }

    if (state.selectedToken == null) {
      emit(
        state.copyWith(transactionStatus: const TransactionStatus.error("")),
      );
      return;
    }

    if (!AddressValidator.validationAddress(inputMint).isValid &&
        inputMint.isNotEmpty) {
      emit(
        state.copyWith(transactionStatus: const TransactionStatus.error("")),
      );
      return;
    }

    final newAmount = multiplyByDecimalPower(
      state.amount,
      state.selectedToken!.decimals,
    ).toString();

    final newPriorityFee = multiplyByDecimalPower(
      priorityFee,
      state.selectedToken!.decimals,
    ).toString();

    if (newAmount == "0") {
      emit(
        state.copyWith(transactionStatus: const TransactionStatus.error("0")),
      );
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      emit(
        state.copyWith(transactionStatus: const TransactionStatus.loading()),
      );

      final response = await _walletTransactionApi.swap(
        fromChainId: state.selectedToken!.chainId.toString(),
        toChainId: state.toToken!.chainId!,
        inputMint: state.selectedToken!.tokenAddress,
        outputMint: state.toToken!.tokenAddress!,
        amount: newAmount,
        slippage: state.slippage.round().toInt(),
        walletId: _walletCubit.state.wallets.first.id!,
        priorityFee: newPriorityFee,
        // paymentPin: paymentPin,
      );

      emit(
        state.copyWith(transactionStatus: TransactionStatus.success(response)),
      );
    } catch (e, s) {
      await SentryService().reportError(
        e,
        s,
        tags: {"feature": "swap"},
        extra: {
          "fromChainId": state.selectedToken!.chainId.toString(),
          "toChainId": state.toToken!.chainId!,
          "inputMint": state.selectedToken!.tokenAddress,
          "outputMint": state.toToken!.tokenAddress!,
          "amount": newAmount,
          "slippage": state.slippage.round().toInt(),
          "walletId": _walletCubit.state.wallets.first.id!,
          "priorityFee": newPriorityFee,
        },
      );
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> getQuote() async {
    if (state.selectedToken == null) {
      return;
    }

    if (state.amount.isEmpty) {
      return;
    }

    if (state.fromChainId == int.tryParse(state.toChainId)) {
      return;
    }

    if (state.outputMint.isEmpty) {
      return;
    }

    final newAmount =
        (Decimal.tryParse(state.amount) ?? Decimal.zero) *
        Decimal.parse(pow(10, state.selectedToken!.decimals).toString());

    if (newAmount == Decimal.zero) {
      return;
    }

    // final newAmount = (double.tryParse(state.amount) ?? 0) *
    //     pow(10, state.selectedToken!.decimals);

    try {
      emit(state.copyWith(quoteStatus: const QuoteStatus.loading()));

      final quote = await _walletTransactionApi.getQuote(
        fromChainId: state.selectedToken!.chainId.toString(), //
        toChainId: state.toToken?.chainId ?? "", //
        inputMint: state.selectedToken!.tokenAddress, //
        // inputMint: state.inputMint,
        outputMint: state.toToken?.tokenAddress ?? "", //
        // outputMint: "0xba2ae424d960c26247dd6c32edc70b295c744c43",
        amount: newAmount.toBigInt().toInt(), // decimal
        slippage: (state.slippage.toInt() * 100).toInt(), //
      );

      emit(
        state.copyWith(quoteStatus: QuoteStatus.success(quote), quote: quote),
      );
    } catch (e, s) {
      emit(state.copyWith(quoteStatus: QuoteStatus.error(e.toString())));
      await SentryService().reportError(
        e,
        s,
        tags: {"feature": "swap"},
        extra: {
          "fromChainId": state.selectedToken!.chainId.toString(), //
          "toChainId": state.toToken?.chainId ?? "", //
          "inputMint": state.selectedToken!.tokenAddress, //
          // inputMint: state.inputMint,
          "outputMint": state.toToken?.tokenAddress ?? "", //
          // outputMint: "0xba2ae424d960c26247dd6c32edc70b295c744c43",
          "amount": newAmount.toBigInt().toInt(), // decimal
          "slippage": (state.slippage.toInt() * 100).toInt(), //
        },
      );
    }
  }
}
