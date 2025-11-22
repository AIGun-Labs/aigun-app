import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utils/logger.dart';
import '../../domain/entities/invite_info_entity.dart';
import '../../domain/usecases/fetch_active_code.dart';
import '../../domain/usecases/fetch_claim_gold.dart';
import '../../domain/usecases/fetch_invite_info.dart';
import '../../domain/usecases/fetch_realtime_funds.dart';

part 'invite_cubit.freezed.dart';
part 'invite_state.dart';

class InviteCubit extends Cubit<InviteState> {
  final FetchRealtimeFunds _fetchRealtimeFunds;
  final FetchInviteInfo _fetchInviteInfo;
  final FetchActiveCode _fetchActiveCode;
  final FetchClaimGold _fetchClaimGold;
  InviteInfoEntity? _inviteInfo;
  InviteCubit(this._fetchRealtimeFunds, this._fetchInviteInfo,
      this._fetchActiveCode, this._fetchClaimGold)
      : super(
          const InviteState.initial(),
        );

  ///领取金币
  Future<void> claimGold() async {
    final result = await _fetchClaimGold.call();
    await result.when(success: (_) async {
      await refreshInviteInfo();
    }, failure: (String message) {
      emit(InviteState.error(message));
    }, loading: () {
      emit(const InviteState.loading());
    });
  }

  ///更新实时资金
  Future<double> updateRealtimeFunds() async {
    final result = await _fetchRealtimeFunds.call();
    final value = result.maybeWhen(
      success: (String value) {
        return double.tryParse(value) ??
            _inviteInfo?.unclaimedDollarValue ??
            0.0;
      },
      orElse: () {
        return _inviteInfo?.unclaimedDollarValue ?? 0.0;
      },
    );

    return value;
  }

  ///绑定邀请码
  Future<void> bindInviteCode(String inviteCode) async {
    final result = await _fetchActiveCode.call(inviteCode);

    Logger.info('bindInviteCode success');
    result.whenOrNull(
      success: (_) async {
        await refreshInviteInfo();
      },
      failure: (String message) {
        throw Exception(message);
      },
    );
  }

  ///刷新邀请信息
  Future<void> refreshInviteInfo() async {
    Logger.info('InviteCubit update inviteInfo');

    final data = await _fetchInviteInfo.call();
    data.when(
      success: (InviteInfoEntity value) {
        _inviteInfo = value;
        emit(InviteState.success(value));
      },
      failure: (String message) => emit(InviteState.error(message)),
      loading: () => emit(const InviteState.loading()),
    );
  }

  ///刷新
  Future<void> refresh() async {
    Logger.info('InviteCubit refresh');
    emit(const InviteState.loading());
    await refreshInviteInfo();
  }

  ///重置
  void reset() {
    _inviteInfo = null;
    emit(const InviteState.initial());
  }
}
