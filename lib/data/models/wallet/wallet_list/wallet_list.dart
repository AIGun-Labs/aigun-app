import 'package:freezed_annotation/freezed_annotation.dart';

import '../index.dart';

part 'wallet_list.freezed.dart';
part 'wallet_list.g.dart';

@freezed
sealed class WalletList with _$WalletList {
  const factory WalletList({@Default([]) List<Wallet> wallets}) = _WalletList;

  factory WalletList.fromJson(Map<String, dynamic> json) =>
      _$WalletListFromJson(json);
}
