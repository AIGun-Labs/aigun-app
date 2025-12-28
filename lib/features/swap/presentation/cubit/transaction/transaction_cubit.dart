import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/count.dart';
import '../../../../../core/polling/polling_service.dart';
import '../../../../../core/types/result.dart';
import '../../../../../data/models/trade/setting/trade_custom_setting.dart';
import '../../../../../enums/trade_mode.dart';
import '../../../../../enums/transaction.dart';
import '../../../../../utils/storage/local/wallet_storage.dart';
import '../../../domain/entities/swap_result_entity.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/entities/transaction_status_entity.dart';
import '../../../domain/usecases/execute_swap.dart';
import '../../../domain/usecases/get_transaction_status.dart';
import 'transaction_state.dart';

///
class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit({
    required ExecuteSwap executeSwap,
    required GetTransactionStatus getTransactionStatus,
    required WalletStorage walletStorage,
  }) : _executeSwap = executeSwap,
       _getTransactionStatus = getTransactionStatus,
       _walletStorage = walletStorage,
       super(const TransactionState());
  final ExecuteSwap _executeSwap;
  final GetTransactionStatus _getTransactionStatus;
  final WalletStorage _walletStorage;

  PollingService<Result<TransactionStatusEntity>>? _pollingService;
  void Function(SwapResultEntity result)? onTransactionSuccess;
  void Function(String? message, int? code)? onTransactionFailure;

  // ==================== Transaction Execution ====================
  ///
  Future<void> executeSwap({
    required TransactionEntity fromToken,
    required TransactionEntity toToken,
    required String amount,
    required TradeCustomSetting options,
    required TradeMode mode,
  }) async {
    final wallet = await _walletStorage.getSelectedWallet();
    if (wallet == null) {
      emit(
        state.copyWith(
          status: const TransactionStatus.failure('Wallet not found'),
          errorMessage: 'Wallet not found',
        ),
      );
      onTransactionFailure?.call('Wallet not found', null);
      return;
    }

    emit(state.copyWith(status: const TransactionStatus.submitting()));

    final result = await _executeSwap.call(
      network: fromToken.network ?? '',
      amount: amount,
      fromChainId: fromToken.uniqueId,
      toChainId: toToken.uniqueId,
      inputMint: fromToken.address,
      outputMint: toToken.address,
      walletId: wallet.id ?? '',
      options: options,
      mode: mode,
      decimals: fromToken.decimals,
    );

    result.whenOrNull(
      success: (transaction) {
        emit(
          state.copyWith(
            status: TransactionStatus.polling(
              txHash: transaction.txHash ?? '',
              txUrl: transaction.txUrl,
            ),
            txHash: transaction.txHash,
            txUrl: transaction.txUrl,
          ),
        );
        _startTransactionStatusPolling(transaction, fromToken);
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: TransactionStatus.failure(error),
            errorMessage: error,
          ),
        );
        onTransactionFailure?.call(error, null);
      },

      be: (be) {
        emit(
          state.copyWith(
            status: TransactionStatus.failure(be.message),
            errorMessage: be.message,
          ),
        );
        onTransactionFailure?.call(be.message, be.code);
      },
    );
  }

  // ==================== Transaction Status Polling ====================
  void _startTransactionStatusPolling(
    SwapResultEntity transaction,
    TransactionEntity fromToken,
  ) {
    _stopPolling();

    _pollingService = PollingService<Result<TransactionStatusEntity>>(
      baseInterval: Duration(seconds: NumericConstants.two),
      fetcher: (cancel) async {
        return await _getTransactionStatus(
          txHash: transaction.txHash ?? '',
          chainId: fromToken.chainId,
          network: fromToken.network ?? '',
        );
      },
      onData: (data) {
        data.whenOrNull(
          success: (value) =>
              _handleTransactionStatus(value.status, transaction),
          failure: (error) {
            _stopPolling();
            emit(
              state.copyWith(
                status: TransactionStatus.failure(error),
                errorMessage: error,
              ),
            );
            onTransactionFailure?.call(error, null);
          },

          be: (be) {
            _stopPolling();
            emit(
              state.copyWith(
                status: TransactionStatus.failure(be.message),
                errorMessage: be.message,
              ),
            );
            onTransactionFailure?.call(be.message, be.code);
          },
        );
      },
      onError: (error, stack) {
        _stopPolling();
        emit(
          state.copyWith(
            status: const TransactionStatus.failure(),
            errorMessage: error.toString(),
          ),
        );
        onTransactionFailure?.call(error.toString(), null);
      },
    )..start();
  }

  void _handleTransactionStatus(String? status, SwapResultEntity transaction) {
    if (status == TransactionStatusEnum.success.value) {
      _stopPolling();
      emit(
        state.copyWith(
          status: TransactionStatus.success(transaction),
          result: transaction,
        ),
      );
      onTransactionSuccess?.call(transaction);
    } else if (status == TransactionStatusEnum.failed.value) {
      _stopPolling();
      emit(
        state.copyWith(
          status: const TransactionStatus.failure('Transaction failed'),
          errorMessage: 'Transaction failed',
        ),
      );
      onTransactionFailure?.call('Transaction failed', null);
    }
  }

  void _stopPolling() {
    _pollingService?.stop();
    _pollingService = null;
  }

  // ==================== State Management ====================
  void reset() {
    _stopPolling();
    emit(const TransactionState());
  }

  void cancel() {
    _stopPolling();
    emit(state.copyWith(status: const TransactionStatus.initial()));
  }

  // ==================== Lifecycle ====================

  @override
  Future<void> close() {
    _stopPolling();
    return super.close();
  }
}
