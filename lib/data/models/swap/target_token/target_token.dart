import 'package:freezed_annotation/freezed_annotation.dart';

part 'target_token.freezed.dart';
part 'target_token.g.dart';

@freezed
sealed class TargetToken with _$TargetToken {
  const factory TargetToken({
    @JsonKey(name: 'chain_id') required String? chainId,
    @JsonKey(name: 'token_name') required String? tokenName,
    @JsonKey(name: 'token_address') required String? tokenAddress,
    @JsonKey(name: 'token_avatar') required String? tokenAvatar,
  }) = _TargetToken;

  factory TargetToken.fromJson(Map<String, dynamic> json) =>
      _$TargetTokenFromJson(json);
}
