import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/types/result.dart';
import '../../domain/entities/invite_info_entity.dart';
import '../../domain/usecases/fetch_active_code.dart';
import '../../domain/usecases/fetch_claim_gold.dart';
import '../../domain/usecases/fetch_invite_info.dart';
import '../../domain/usecases/fetch_realtime_funds.dart';

part 'invite_cubit.freezed.dart';
part 'invite_state.dart';

class InviteCubit extends Cubit<InviteState> {
  InviteCubit(
    this._fetchRealtimeFunds,
    this._fetchInviteInfo,
    this._fetchActiveCode,
    this._fetchClaimGold,
  ) : super(const InviteState(status: InviteStateStatus.initial));
  final FetchRealtimeFunds _fetchRealtimeFunds;
  final FetchInviteInfo _fetchInviteInfo;
  final FetchActiveCode _fetchActiveCode;
  final FetchClaimGold _fetchClaimGold;

  Timer? _realtimeFundsTimer;

  ///初始化
  Future<void> init() async {
    emit(state.copyWith(status: InviteStateStatus.initial));
    await _refreshInviteInfo();
  }

  ///领取金币
  Future<void> claimGold() async {
    final result = await _fetchClaimGold.call();

    result.whenOrNull(
      success: (_) async => {
        emit(state.copyWith(effect: InviteStateEffect.claimGoldSuccess)),
        await _refreshInviteInfo(),
      },
      failure: (String message) =>
          emit(state.copyWith(effect: InviteStateEffect.claimGoldFailure)),
    );
  }

  ///更新实时资金
  Future<void> updateRealtimeFunds() async {
    final result = await _fetchRealtimeFunds.call();
    if (isClosed) return;
    result.whenOrNull(
      success: (String value) {
        emit(
          state.copyWith(
            inviteInfo: state.inviteInfo?.copyWith(totalUnclaimedAmount: value),
          ),
        );
      },
    );
  }

  ///绑定邀请码
  Future<void> bindInviteCode(String inviteCode) async {
    final result = await _fetchActiveCode.call(inviteCode);

    result.whenOrNull(
      success: (_) async {
        emit(state.copyWith(effect: InviteStateEffect.bindInviteSuccess));
        await _refreshInviteInfo();
      },
      failure: (String message) {
        emit(state.copyWith(effect: InviteStateEffect.bindInviteFailure));
      },
    );
  }

  ///刷新邀请信息
  Future<void> _refreshInviteInfo() async {
    final data = await _fetchInviteInfo.call();
    data.whenOrNull(
      success: (InviteInfoEntity value) => emit(
        state.copyWith(status: InviteStateStatus.success, inviteInfo: value),
      ),
      failure: (String message) => emit(
        state.copyWith(status: InviteStateStatus.error, errorMessage: message),
      ),
    );
  }

  ///刷新
  Future<void> refresh() async {
    await _refreshInviteInfo();
  }

  Future<void> startPollingRealtimeFunds() async {
    _realtimeFundsTimer?.cancel();
    _realtimeFundsTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      await updateRealtimeFunds();
    });
  }

  void stopPollingRealtimeFunds() {
    _realtimeFundsTimer?.cancel();
    _realtimeFundsTimer = null;
  }

  void clearEffect() {
    emit(state.copyWith(effect: null));
  }

  @override
  Future<void> close() {
    stopPollingRealtimeFunds();
    return super.close();
  }
}
