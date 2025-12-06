import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/entities/base_token_entity.dart';

part 'top_token_entity.freezed.dart';

@Freezed()
class TopTokenEntity with _$TopTokenEntity {
  @override
  final String? id;
  @override
  final DateTime? displayTime;

  @override
  final BaseTokenEntity base;

  const TopTokenEntity({required this.base, this.id = '', this.displayTime});
}
