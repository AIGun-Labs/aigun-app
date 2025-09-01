import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_state.freezed.dart';

@freezed
class WalletState with _$WalletState {
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
