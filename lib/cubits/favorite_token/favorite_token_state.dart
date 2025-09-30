import 'package:flutter_aigun/data/models/token_detail/token/favorite_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_token_state.freezed.dart';

@freezed
class FavoriteTokenListStatus with _$FavoriteTokenListStatus {
  const factory FavoriteTokenListStatus.initial() = _ListInitial;
  const factory FavoriteTokenListStatus.loading() = _ListLoading;
  const factory FavoriteTokenListStatus.success(List<FavoriteToken> tokens) =
      _ListSuccess;
  const factory FavoriteTokenListStatus.error(String message) = _ListError;
}

@freezed
class FavoriteTokenActionStatus with _$FavoriteTokenActionStatus {
  const factory FavoriteTokenActionStatus.idle() = _ActionIdle;
  const factory FavoriteTokenActionStatus.adding() = _ActionAdding;
  const factory FavoriteTokenActionStatus.removing() = _ActionRemoving;
  const factory FavoriteTokenActionStatus.success() = _ActionSuccess;
  const factory FavoriteTokenActionStatus.error(String message) = _ActionError;
}

@freezed
class FavoriteTokenState with _$FavoriteTokenState {
  const factory FavoriteTokenState({
    @Default([]) List<FavoriteToken> tokens,
    @Default([]) List<FavoriteToken> favoriteTokens,
    @Default(FavoriteTokenListStatus.initial()) FavoriteTokenListStatus listStatus,
    @Default(FavoriteTokenActionStatus.idle()) FavoriteTokenActionStatus actionStatus,
  }) = _FavoriteTokenState;


}
