import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/token_entity.dart';
import '../../data/models/realtime_request_model.dart';
import '../../domain/entities/realtime_entity.dart';
// import '../../domain/entities/top_token_entity.dart';
import '../../domain/usecases/fetch_realtime.dart';
import '../../domain/usecases/fetch_top_tokens.dart';

part 'top_token_cubit.freezed.dart';
part 'top_token_state.dart';

class TopTokenCubit extends Cubit<TopTokenState> {
  final FetchTopTokens _fetchTopTokens;
  final FetchRealtime _fetchRealtime;

  TopTokenCubit(this._fetchTopTokens, this._fetchRealtime)
    : super(const TopTokenState());

  Timer? _realtimeTimer;

  String _buildKey(TokenEntity e) => '${e.network}-${e.address}';

  Future<void> init() async {
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
        lastTime: null, // 刷新时重置游标
        errorMessage: null,
      ),
    );

    final result = await _fetchTopTokens.call(null);

    _handleResult(result, isLoadMore: false);
  }

  Future<void> loadMore() async {
    if (state.status == TopTokenStatus.loading || !state.hasMore) return;

    final result = await _fetchTopTokens.call(state.lastTime);

    _handleResult(result, isLoadMore: true);
  }

  void _handleResult(
    Result<List<TokenEntity>> result, {
    bool isLoadMore = false,
  }) {
    result.whenOrNull(
      success: (newTokens) {
        if (newTokens.isEmpty) {
          emit(state.copyWith(hasMore: false, status: TopTokenStatus.success));

          return;
        }

        final nextLastTime = newTokens.last.extra?.displayTime?.toString();

        emit(
          state.copyWith(
            status: TopTokenStatus.success,
            tokens: isLoadMore ? [...state.tokens, ...newTokens] : newTokens,
            hasMore: true,
            lastTime: nextLastTime,
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
        .where((e) => state.visibleTokenKeys.contains(_buildKey(e)))
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

  void updateTokenVisibility(TokenEntity token, bool isVisible) {
    final key = _buildKey(token);

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
