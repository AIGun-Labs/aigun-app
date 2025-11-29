import 'package:freezed_annotation/freezed_annotation.dart';

part 'chain.freezed.dart';
part 'chain.g.dart';

@freezed
sealed class Chain with _$Chain {
  const factory Chain({
    @JsonKey(name: 'chain_id') required String chainId,
    @JsonKey(name: 'chain_type') required String chainType,
    @JsonKey(name: 'chain_name') required String chainName,
    @JsonKey(name: 'logo_url') required String logoUrl,
    @JsonKey(name: 'explorer') required String explorer,
  }) = _Chain;

  factory Chain.fromJson(Map<String, dynamic> json) => _$ChainFromJson(json);
}
