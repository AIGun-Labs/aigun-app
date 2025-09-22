import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_token_state.freezed.dart';

@freezed
class FavoriteTokenStatus with _$FavoriteTokenStatus {
  const factory FavoriteTokenStatus.initial() = _Initial;
  const factory FavoriteTokenStatus.loading() = _Loading;
  const factory FavoriteTokenStatus.success(List<Token> tokens) = _Success;
  const factory FavoriteTokenStatus.error(String message) = _Error;
}

@freezed
class FavoriteTokenState with _$FavoriteTokenState {
  const factory FavoriteTokenState({
    @Default([]) List<Token> tokens,
    @Default(FavoriteTokenStatus.initial()) FavoriteTokenStatus status,
  }) = _FavoriteTokenState;
}
