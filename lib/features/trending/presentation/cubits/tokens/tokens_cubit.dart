import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/types/result.dart';
import '../../../../../shared/data/mappers/trade_token_mapper.dart';
import '../../../../../shared/domain/entities/base_token_entity.dart';
import '../../../domain/usecases/fetch_realtime_usecase.dart';
import '../../../domain/usecases/fetch_tokens_usecase.dart';

part 'tokens_cubit.freezed.dart';
part 'tokens_state.dart';

class TokensCubit extends Cubit<TokensState> {
  TokensCubit(this._fetchTokens, this._fetchRealtime)
    : super(const TokensState());
  final FetchTokensUsecase _fetchTokens;
  final FetchRealtimeUsecase _fetchRealtime;

  Timer? _realtimeTimer;

  void setParams({
    Map<String, dynamic>? queryParameters,
    String? paginationField,
  }) {
    emit(
      state.copyWith(
        queryParameters: queryParameters,
        paginationField: paginationField,
        hasMore: paginationField != null,
      ),
    );
  }

  Future<void> init({
    Map<String, dynamic>? queryParameters,
    String? paginationField,
  }) async {
    if (state.status != TokensStatus.initial) return;
    await refresh();
  }

  void startRealtimeTimer() {
    _realtimeTimer?.cancel();
    _realtimeTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _getRealtime();
    });
  }

  void stopRealtimeTimer() {
    _realtimeTimer?.cancel();
    _realtimeTimer = null;
  }

  Future<void> refresh() async {
    emit(
      state.copyWith(
        status: TokensStatus.loading,
        errorMessage: null,
        isLoadingMore: false,
      ),
    );

    final result = await _fetchTokens.call(
      queryParameters: state.queryParameters,
    );

    _handleResult(result, isLoadMore: false);
  }

  Future<void> loadMore() async {
    if (state.status == TokensStatus.loading ||
        !state.hasMore ||
        state.isLoadingMore ||
        state.tokens.isEmpty)
      return;

    emit(state.copyWith(isLoadingMore: true, errorMessage: null));

    final result = await _fetchTokens.call(
      queryParameters: {
        ...(state.queryParameters ?? {}),
        if (state.paginationField != null)
          state.paginationField!: state.tokens.last
              .toTradeTokenModel()
              .toJson()[state.paginationField!]
              .toString(),
      },
    );

    _handleResult(result, isLoadMore: true);
  }

  void _handleResult(
    Result<List<BaseTokenEntity>> result, {
    bool isLoadMore = false,
  }) {
    result.whenOrNull(
      success: (newTokens) {
        if (newTokens.isEmpty) {
          emit(
            state.copyWith(
              hasMore: false,
              status: TokensStatus.success,
              isLoadingMore: false,
            ),
          );

          return;
        }
        emit(
          state.copyWith(
            status: TokensStatus.success,
            tokens: isLoadMore ? [...state.tokens, ...newTokens] : newTokens,
            hasMore: state.paginationField != null,
            isLoadingMore: false,
          ),
        );
      },
      failure: (String message) {
        emit(
          state.copyWith(
            status: TokensStatus.failure,
            errorMessage: message,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  Future<void> _getRealtime() async {
    if (state.visibleTokenKeys.isEmpty) return;

    final visibleTokens = state.tokens
        .where((e) => state.visibleTokenKeys.contains(e.uniqueId))
        .toList();

    if (visibleTokens.isEmpty || isClosed) return;

    final result = await _fetchRealtime.call(
      body: visibleTokens,
      queryParameters: state.queryParameters,
    );

    if (isClosed) return;

    result.whenOrNull(
      success: (newRealtime) {
        final newMap = <String, BaseTokenEntity>{
          for (final r in newRealtime) r.uniqueId: r,
        };

        emit(state.copyWith(realtimeMap: {...state.realtimeMap, ...newMap}));
      },
    );
  }

  void updateTokenVisibility(BaseTokenEntity token, bool isVisible) {
    final key = token.uniqueId;

    final visibleSet = {...state.visibleTokenKeys};

    if (isVisible) {
      visibleSet.add(key);
    } else {
      visibleSet.remove(key);
    }
    emit(state.copyWith(visibleTokenKeys: visibleSet));
  }

  @override
  Future<void> close() {
    stopRealtimeTimer();
    return super.close();
  }
}
