import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/index.dart';

part "wallet_state.freezed.dart";

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    @Default(WalletStatus.initial()) WalletStatus status,
    @Default([]) List<Wallet> wallets,
    Wallet? selectedWallet,
    @Default(0) double balance,
  }) = _WalletState;
}

@freezed
class WalletStatus with _$WalletStatus {
  const factory WalletStatus.initial() = _Initial;
  const factory WalletStatus.loading() = _Loading;
  const factory WalletStatus.success() = _Success;
  const factory WalletStatus.error(String message) = _Error;
}
