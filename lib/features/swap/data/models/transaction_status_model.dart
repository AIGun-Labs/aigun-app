import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/transaction_status_entity.dart';

part "transaction_status_model.freezed.dart";
part "transaction_status_model.g.dart";

@freezed
sealed class TransactionStatusModel with _$TransactionStatusModel {
  const TransactionStatusModel._();
  const factory TransactionStatusModel({
    @JsonKey(name: "status") String? status,
  }) = _TransactionStatusModel;

  factory TransactionStatusModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionStatusModelFromJson(json);

  TransactionStatusEntity toEntity() => TransactionStatusEntity(status: status);
}
