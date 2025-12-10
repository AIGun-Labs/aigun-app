import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../data/models/realtime_request_model.dart';
import '../../domain/entities/realtime_entity.dart';
import '../../domain/usecases/fetch_realtime_usecase.dart';
import '../../domain/usecases/fetch_tokens_usecase.dart';

part 'top_token_cubit.freezed.dart';
part 'top_token_state.dart';

class TopTokenCubit extends Cubit<TopTokenState> {
  final FetchTokensUsecase _fetchTokens;
  final FetchRealtimeUsecase _fetchRealtime;

  TopTokenCubit(this._fetchTokens, this._fetchRealtime)
    : super(const TopTokenState());

  Timer? _realtimeTimer;

  Future<void> init({
    Map<String, dynamic>? queryParameters,
    String? paginationField,
  }) async {
    emit(
      state.copyWith(
        queryParameters: queryParameters,
        paginationField: paginationField,
      ),
    );
    if (state.status != TopTokenStatus.initial) return;
    await refresh();
  }

  void startRealtimeTimer() {
    _realtimeTimer?.cancel();
    _realtimeTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      getRealtime();
    });
  }

  void stopRealtimeTimer() {
    _realtimeTimer?.cancel();
    _realtimeTimer = null;
  }

  Future<void> refresh() async {
    emit(
      state.copyWith(
        status: TopTokenStatus.loading,
        hasMore: true,
        errorMessage: null,
      ),
    );

    final result = await _fetchTokens.call(
      queryParameters: state.queryParameters,
    );

    _handleResult(result, isLoadMore: false);
  }

  Future<void> loadMore() async {
    if (state.status == TopTokenStatus.loading || !state.hasMore) return;

    final result = await _fetchTokens.call(
      queryParameters: {
        ...(state.queryParameters ?? {}),
        if (state.paginationField != null)
          state.paginationField!: state.tokens.last
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
          emit(state.copyWith(hasMore: false, status: TopTokenStatus.success));

          return;
        }
        emit(
          state.copyWith(
            status: TopTokenStatus.success,
            tokens: isLoadMore ? [...state.tokens, ...newTokens] : newTokens,
            hasMore: true,
          ),
        );
      },
      failure: (String message) {
        emit(
          state.copyWith(status: TopTokenStatus.failure, errorMessage: message),
        );
      },
    );
  }

  Future<void> getRealtime() async {
    if (state.visibleTokenKeys.isEmpty) return;

    final visibleTokens = state.tokens
        .where((e) => state.visibleTokenKeys.contains(e.uniqueId))
        .toList();

    if (visibleTokens.isEmpty) return;

    final data = visibleTokens
        .map(
          (e) => RealtimeRequestModel(network: e.network, address: e.address),
        )
        .toList();
    final result = await _fetchRealtime.call(data);

    result.whenOrNull(
      success: (newRealtime) {
        final newMap = <String, RealtimeEntity>{
          for (final r in newRealtime) '${r.network}-${r.contractAddress}': r,
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
    // TODO: implement close
    stopRealtimeTimer();
    return super.close();
  }
}
