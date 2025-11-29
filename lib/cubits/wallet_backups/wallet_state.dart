import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/index.dart';
import '../../data/models/wallet/token/token.dart';

part 'wallet_state.freezed.dart';

@freezed
sealed class WalletState with _$WalletState {
  const factory WalletState({
    @Default(false) bool isLoading,
    @Default(false) bool isFetched,
    @Default('') String errorMessage,
    @Default(true) bool isPaymentPin,
    @Default(false) bool isCreating,
    @Default([]) List<Wallet> wallets,
    String? selectedWalletAddress,
    @Default([]) List<Token> tokens,
    @Default(0) double totalBalance,
    @Default([]) List<Chain> chains,
  }) = _WalletState;
}
