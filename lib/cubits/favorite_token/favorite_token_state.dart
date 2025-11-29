import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/token_detail/token/favorite_token.dart';

part 'favorite_token_state.freezed.dart';

@freezed
class FavoriteTokenListStatus with _$FavoriteTokenListStatus {
  const factory FavoriteTokenListStatus.initial() = _ListInitial;
  const factory FavoriteTokenListStatus.loading() = _ListLoading;
  const factory FavoriteTokenListStatus.success(List<FavoriteToken> tokens) =
      ListSuccess;
  const factory FavoriteTokenListStatus.error(String message) = ListError;
}

@freezed
class FavoriteTokenActionStatus with _$FavoriteTokenActionStatus {
  const factory FavoriteTokenActionStatus.idle() = ActionIdle;
  const factory FavoriteTokenActionStatus.adding() = ActionAdding;
  const factory FavoriteTokenActionStatus.removing() = ActionRemoving;
  const factory FavoriteTokenActionStatus.pinning() = ActionPinning;
  const factory FavoriteTokenActionStatus.success() = ActionSuccess;
  const factory FavoriteTokenActionStatus.error(String message) = ActionError;
}

@freezed
sealed class FavoriteTokenState with _$FavoriteTokenState {
  const factory FavoriteTokenState({
    @Default([]) List<FavoriteToken> tokens,
    @Default([]) List<FavoriteToken> favoriteTokens,
    @Default(FavoriteTokenListStatus.initial())
    FavoriteTokenListStatus listStatus,
    @Default(FavoriteTokenActionStatus.idle())
    FavoriteTokenActionStatus actionStatus,
  }) = _FavoriteTokenState;
}
