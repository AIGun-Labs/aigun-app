import 'package:flutter_aigun/data/models/wallet/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "wallet_list.freezed.dart";
part "wallet_list.g.dart";

@freezed
class WalletList with _$WalletList {
  const factory WalletList({
    @Default([]) List<Wallet> wallets,
  }) = _WalletList;

  factory WalletList.fromJson(Map<String, dynamic> json) =>
      _$WalletListFromJson(json);
}
