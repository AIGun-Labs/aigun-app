import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/types/result.dart';
import '../../../../utils/logger.dart';
import '../../domain/entities/claim_token_entity.dart';
import '../../domain/usecases/claim_token.dart';
import '../../domain/usecases/unclaimed_tokens.dart';

part 'claim_token_cubit.freezed.dart';
part 'claim_token_state.dart';

class ClaimTokenCubit extends Cubit<ClaimTokenState> {
  ClaimTokenCubit(this._unclaimedTokens, this._claimToken)
    : super(const ClaimTokenState.initial());
  final UnclaimedTokens _unclaimedTokens;
  final ClaimToken _claimToken;

  ///初始化
  Future<void> init() async {
    Logger.info('ClaimTokenCubit init');
    emit(const ClaimTokenState.loading());
    await getUnclaimedTokens();
  }

  ///领取代币
  Future<void> claimToken(ClaimTokenEntity token) async {
    await _claimToken.call(token.network, token.contract, token.amount);
  }

  ///获取未领取的代币
  Future<void> getUnclaimedTokens() async {
    final result = await _unclaimedTokens.call();

    result.whenOrNull(
      success: (List<ClaimTokenEntity> tokens) =>
          emit(ClaimTokenState.success(tokens)),
      loading: () => emit(const ClaimTokenState.loading()),
      failure: (String message) => emit(ClaimTokenState.error(message)),
    );
  }
}
