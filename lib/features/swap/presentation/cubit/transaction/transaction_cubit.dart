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

/// TransactionCubit 负责管理交易执行和状态轮询
///
/// 职责：
/// - 执行 swap 交易
/// - 交易状态轮询（使用 PollingService）
/// - 发出交易相关事件
class TransactionCubit extends Cubit<TransactionState> {
  final ExecuteSwap _executeSwap;
  final GetTransactionStatus _getTransactionStatus;
  final WalletStorage _walletStorage;

  PollingService<Result<TransactionStatusEntity>>? _pollingService;

  /// 交易成功回调
  void Function(SwapResultEntity result)? onTransactionSuccess;

  /// 交易失败回调
  void Function(String? message)? onTransactionFailure;

  TransactionCubit({
    required ExecuteSwap executeSwap,
    required GetTransactionStatus getTransactionStatus,
    required WalletStorage walletStorage,
  })  : _executeSwap = executeSwap,
        _getTransactionStatus = getTransactionStatus,
        _walletStorage = walletStorage,
        super(const TransactionState());

  // ==================== Transaction Execution ====================

  /// 执行 Swap 交易
  ///
  /// [fromToken] 源代币
  /// [toToken] 目标代币
  /// [amount] 交易金额（原子单位）
  /// [options] 交易设置选项
  /// [mode] 交易模式
  Future<void> executeSwap({
    required TransactionEntity fromToken,
    required TransactionEntity toToken,
    required String amount,
    required TradeCustomSetting options,
    required TradeMode mode,
  }) async {
    // 获取用户钱包
    final wallet = await _walletStorage.getSelectedWallet();
    if (wallet == null) {
      emit(state.copyWith(
        status: const TransactionStatus.failure('Wallet not found'),
        errorMessage: 'Wallet not found',
      ));
      onTransactionFailure?.call('Wallet not found');
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
        emit(state.copyWith(
          status: TransactionStatus.polling(
            txHash: transaction.txHash ?? '',
            txUrl: transaction.txUrl,
          ),
          txHash: transaction.txHash,
          txUrl: transaction.txUrl,
        ));
        _startTransactionStatusPolling(transaction, fromToken);
      },
      failure: (error) {
        emit(state.copyWith(
          status: TransactionStatus.failure(error),
          errorMessage: error,
        ));
        onTransactionFailure?.call(error);
      },
    );
  }

  // ==================== Transaction Status Polling ====================

  /// 启动交易状态轮询
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
            emit(state.copyWith(
              status: TransactionStatus.failure(error),
              errorMessage: error,
            ));
            onTransactionFailure?.call(error);
          },
        );
      },
      onError: (error, stack) {
        _stopPolling();
        emit(state.copyWith(
          status: const TransactionStatus.failure(),
          errorMessage: error.toString(),
        ));
        onTransactionFailure?.call(error.toString());
      },
    )..start();
  }

  /// 处理交易状态
  void _handleTransactionStatus(
    String? status,
    SwapResultEntity transaction,
  ) {
    if (status == TransactionStatusEnum.success.value) {
      _stopPolling();
      emit(state.copyWith(
        status: TransactionStatus.success(transaction),
        result: transaction,
      ));
      onTransactionSuccess?.call(transaction);
    } else if (status == TransactionStatusEnum.failed.value) {
      _stopPolling();
      emit(state.copyWith(
        status: const TransactionStatus.failure('Transaction failed'),
        errorMessage: 'Transaction failed',
      ));
      onTransactionFailure?.call('Transaction failed');
    }
    // 其他状态（pending）继续轮询
  }

  /// 停止轮询
  void _stopPolling() {
    _pollingService?.stop();
    _pollingService = null;
  }

  // ==================== State Management ====================

  /// 重置交易状态
  void reset() {
    _stopPolling();
    emit(const TransactionState());
  }

  /// 取消当前交易（停止轮询）
  void cancel() {
    _stopPolling();
    emit(state.copyWith(
      status: const TransactionStatus.initial(),
    ));
  }

  // ==================== Lifecycle ====================

  @override
  Future<void> close() {
    _stopPolling();
    return super.close();
  }
}
