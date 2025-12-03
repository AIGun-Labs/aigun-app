import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_status_entity.freezed.dart';
part 'transaction_status_entity.g.dart';

@freezed
sealed class TransactionStatusEntity with _$TransactionStatusEntity {
  const factory TransactionStatusEntity({
    @JsonKey(name: "status") String? status,
  }) = _TransactionStatusEntity;

  factory TransactionStatusEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionStatusEntityFromJson(json);
}
