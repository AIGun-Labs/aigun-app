import 'package:flutter_aigun/data/models/token_detail/token/favorite_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_token_state.freezed.dart';

@freezed
class FavoriteTokenStatus with _$FavoriteTokenStatus {
  const factory FavoriteTokenStatus.initial() = _Initial;
  const factory FavoriteTokenStatus.loading() = _Loading;
  const factory FavoriteTokenStatus.success(List<FavoriteToken> tokens) =
      _Success;
  const factory FavoriteTokenStatus.error(String message) = _Error;
}

@freezed
class FavoriteTokenState with _$FavoriteTokenState {
  const factory FavoriteTokenState({
    @Default([]) List<FavoriteToken> tokens,
    @Default([]) List<FavoriteToken> favoriteTokens,
    @Default(FavoriteTokenStatus.initial()) FavoriteTokenStatus status,
  }) = _FavoriteTokenState;

  
}
