import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_user.freezed.dart';
part 'wallet_user.g.dart';

@freezed
sealed class WalletUser with _$WalletUser {
  const factory WalletUser({
    @JsonKey(name: 'wallet_user_id') String? walletUserId,
    @JsonKey(name: 'organization_id') String? organizationId,
  }) = _WalletUser;

  factory WalletUser.fromJson(Map<String, dynamic> json) =>
      _$WalletUserFromJson(json);
}
