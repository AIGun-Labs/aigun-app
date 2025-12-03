import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/transaction_entity.dart';

part 'swap_token_model.freezed.dart';
part 'swap_token_model.g.dart';

/// Swap Token 数据模型 - 用于本地存储的 JSON 序列化
@freezed
sealed class SwapTokenModel with _$SwapTokenModel {
  const SwapTokenModel._();

  const factory SwapTokenModel({
    @JsonKey(name: 'chain_id') required String chainId,
    @JsonKey(name: 'chain_logo') required String chainLogo,
    @JsonKey(name: 'chain_name') required String chainName,
    @JsonKey(name: 'token_avatar') required String tokenAvatar,
    @JsonKey(name: 'token_name') required String tokenName,
    @JsonKey(name: 'address') required String address,
    @JsonKey(name: 'decimals') required int decimals,
    @JsonKey(name: 'symbol') required String symbol,
    @JsonKey(name: 'token_price') required double tokenPrice,
    @JsonKey(name: 'is_native') required bool isNative,
    @JsonKey(name: 'balance') String? balance,
    @JsonKey(name: 'network') String? network,
  }) = _SwapTokenModel;

  factory SwapTokenModel.fromJson(Map<String, dynamic> json) =>
      _$SwapTokenModelFromJson(json);

  /// 从 Entity 创建 Model
  factory SwapTokenModel.fromEntity(TransactionEntity entity) {
    return SwapTokenModel(
      chainId: entity.chainId,
      chainLogo: entity.chainLogo,
      chainName: entity.chainName,
      tokenAvatar: entity.tokenAvatar,
      tokenName: entity.tokenName,
      address: entity.address,
      decimals: entity.decimals,
      symbol: entity.symbol,
      tokenPrice: entity.tokenPrice,
      isNative: entity.isNative,
      balance: entity.balance,
      network: entity.network,
    );
  }

  /// 转换为 Domain Entity
  TransactionEntity toEntity() {
    return TransactionEntity(
      chainId: chainId,
      chainLogo: chainLogo,
      chainName: chainName,
      tokenAvatar: tokenAvatar,
      tokenName: tokenName,
      address: address,
      decimals: decimals,
      symbol: symbol,
      tokenPrice: tokenPrice,
      isNative: isNative,
      balance: balance,
      network: network,
    );
  }
}
