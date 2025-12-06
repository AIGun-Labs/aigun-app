import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/entities/base_token_entity.dart';

part 'collect_token_entity.freezed.dart';

@Freezed()
class CollectTokenEntity with _$CollectTokenEntity {
  @override
  final bool? isTop;

  @override
  final BaseTokenEntity base;

  const CollectTokenEntity({required this.base, this.isTop = false});
}
