import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
  Future<void> init() async {
    return;
  }

  Future<void> claimGold() async {
    return;
  }

  Future<void> updateRealtimeFunds() async {
    return;
  }

  void setInviteCode(String inviteCode) {
    emit(state.copyWith(inviteCode: inviteCode.trim().toUpperCase()));
  }

  Future<void> bindInviteCode(String inviteCode) async {
    return;
  }

  Future<void> _refreshInviteInfo() async {
    return;
  }

  Future<void> refresh() async {
    return;
  }

  Future<void> startPollingRealtimeFunds() async {
    return;
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
