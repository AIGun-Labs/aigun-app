import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/token_security_entity.dart';
import '../../../domain/usecases/fetch_token_security.dart'
    show FetchTokenSecurity;

part 'token_security_cubit.freezed.dart';
part 'token_security_state.dart';

class TokenSecurityCubit extends Cubit<TokenSecurityState> {
  final FetchTokenSecurity _fetchTokenSecurity;

  TokenSecurityCubit(this._fetchTokenSecurity)
    : super(const TokenSecurityState());

  Future<void> getTokenSecurity({
    required String address,
    required String network,
  }) async {
    emit(const TokenSecurityState(status: TokenSecurityStatus.loading));

    final result = await _fetchTokenSecurity.call(
      address: address,
      network: network,
    );
    if (result.isSuccess) {
      emit(
        TokenSecurityState(
          status: TokenSecurityStatus.success,
          tokenSecurity: result.value,
        ),
      );
    } else {
      emit(
        TokenSecurityState(
          status: TokenSecurityStatus.error,
          errorMessage: result.errorMessage!,
        ),
      );
    }
  }
}
