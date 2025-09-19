import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_detail_state.freezed.dart';

@freezed
class TokenDetailState with _$TokenDetailState {
  const factory TokenDetailState({
    @Default(null) Token? token,
  }) = _TokenDetailState;
}
