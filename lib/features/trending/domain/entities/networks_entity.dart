import 'package:freezed_annotation/freezed_annotation.dart';

part 'networks_entity.freezed.dart';

@freezed
sealed class NetworksEntity with _$NetworksEntity {
  const NetworksEntity._();
  const factory NetworksEntity({required Map<String, String> networks}) =
      _NetworksEntity;
}
