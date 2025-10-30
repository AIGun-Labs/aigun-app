import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/fetch_active_code.dart';
import '../../domain/usecases/fetch_claim_gold.dart';
import '../../domain/usecases/fetch_invite_info.dart';
import '../../domain/usecases/fetch_realtime_funds.dart';
import 'invite_state.dart';

///TODO : 邀请码相关逻辑
class InviteCubit extends Cubit<InviteState> {
  final FetchRealtimeFunds _fetchRealtimeFunds;
  final FetchInviteInfo _fetchInviteInfo;
  final FetchActiveCode _fetchActiveCode;
  final FetchClaimGold _fetchClaimGold;

  InviteCubit(this._fetchRealtimeFunds, this._fetchInviteInfo,
      this._fetchActiveCode, this._fetchClaimGold)
      : super(const InviteState.initial());
}
