import 'package:freezed_annotation/freezed_annotation.dart';

part 'chain.freezed.dart';
part 'chain.g.dart';

@freezed
class Chain with _$Chain {
  const factory Chain({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'symbol') required String symbol,
    @JsonKey(name: 'slug') required String slug,
    @JsonKey(name: 'rpc') required String rpc,
    @JsonKey(name: 'okx_chain_index') required String okxChainIndex,
    @JsonKey(name: 'chain_id') required String chainId,
    @JsonKey(name: 'logo') required String logo,
    @JsonKey(name: 'chain_type') required String chainType,
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'main_token') required String mainToken,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'deleted_at') String? deletedAt,
  }) = _Chain;

  factory Chain.fromJson(Map<String, dynamic> json) => _$ChainFromJson(json);
}
