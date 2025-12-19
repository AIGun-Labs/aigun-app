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

  void setInviteCode(String inviteCode) {
    emit(state.copyWith(inviteCode: inviteCode.trim().toUpperCase()));
  }

  ///绑定邀请码
  Future<void> bindInviteCode(String inviteCode) async {
    // emit(state.copyWith(inviteCodeStatus: const InviteCodeStatus.initial()));
    // 去除空格并转大写
    // final trimmedCode = inviteCode.trim().toUpperCase();
    // 正则校验
    if (RegExp(r'\s').hasMatch(state.inviteCode)) {
      emit(
        state.copyWith(
          inviteCodeStatus: const InviteCodeStatus.error(
            InviteFailureType.format,
          ),
        ),
      );
      return;
    }

    final result = await _fetchActiveCode.call(state.inviteCode.toUpperCase());

    result.whenOrNull(
      success: (_) async {
        emit(
          state.copyWith(
            effect: InviteStateEffect.bindInviteSuccess,
            inviteCodeStatus: const InviteCodeStatus.success(),
          ),
        );
        await _refreshInviteInfo();
      },
      failure: (String message) {
        emit(
          state.copyWith(
            effect: InviteStateEffect.bindInviteFailure,
            inviteCodeStatus: const InviteCodeStatus.error(
              InviteFailureType.invalid,
            ),
          ),
        );
      },
    );
  }

  ///刷新邀请信息
  Future<void> _refreshInviteInfo() async {
    final data = await _fetchInviteInfo.call();
    data.whenOrNull(
      success: (InviteInfoEntity value) => emit(
        state.copyWith(
          status: InviteStateStatus.success,
          inviteInfo: value,
          inviteCodeStatus: const InviteCodeStatus.initial(), // 重置状态避免重复触发
        ),
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

  void reset() {
    emit(
      state.copyWith(
        effect: null,
        inviteCodeStatus: const InviteCodeStatus.initial(),
        inviteCode: '',
        errorMessage: '',
      ),
    );
  }

  @override
  Future<void> close() {
    stopPollingRealtimeFunds();
    return super.close();
  }
}
