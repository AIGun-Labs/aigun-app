import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/token_info_entity.dart';
import '../../../domain/usecases/fetch_token_detail_info.dart';

part 'token_info_cubit.freezed.dart';
part 'token_info_state.dart';

class TokenInfoCubit extends Cubit<TokenInfoState> {
  final FetchTokenDetailInfo _fetchTokenDetailInfo;

  TokenInfoCubit(this._fetchTokenDetailInfo) : super(TokenInfoState.initial());

  Future<void> fetchTokenDetailInfo({
    required String address,
    required String network,
  }) async {
    emit(TokenInfoState.loading());
    final result = await _fetchTokenDetailInfo.call(
      address: address,
      network: network,
    );
    if (result.isSuccess) {
      emit(TokenInfoState.success(result.value!));
    } else {
      emit(TokenInfoState.error(result.errorMessage!));
    }
  }
}
