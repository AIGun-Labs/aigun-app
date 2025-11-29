import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_privatekey.freezed.dart';
part 'export_privatekey.g.dart';

@freezed
sealed class ExportPrivateKey with _$ExportPrivateKey {
  const factory ExportPrivateKey({
    required String address,
    @JsonKey(name: 'private_key') required String privateKey,
  }) = _ExportPrivateKey;

  factory ExportPrivateKey.fromJson(Map<String, dynamic> json) =>
      _$ExportPrivateKeyFromJson(json);
}
