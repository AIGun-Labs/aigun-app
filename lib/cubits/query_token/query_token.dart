import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../../data/services/api/query_token.dart';
import '../../data/services/sentry_service.dart';
import '../../utils/storage/local/wallet_storage.dart';
import 'query_token_state.dart';

class QueryTokenCubit extends Cubit<QueryTokenState> {
  QueryTokenCubit() : super(const QueryTokenState());

  Future<void> queryTokens(String keyword) async {
    if (keyword.isEmpty) {
      reset();
      return;
    }
    if (state.isLoading == true) {
      return;
    }
    if (state.keyword == keyword) {
      return;
    }

    try {
      emit(state.copyWith(
          isLoading: true, keyword: keyword, status: QueryTokenStatus.loading));
      final wallet = await getIt<WalletStorage>().getSelectedWallet();

      final tokens = await getIt<QueryTokenApi>()
          .queryToken(keyWord: keyword, walletId: wallet?.id ?? '');

      if (tokens.isEmpty) {
        emit(state.copyWith(
            noData: true,
            tokens: [],
            isLoading: false,
            status: QueryTokenStatus.success));
      } else {
        emit(state.copyWith(
            tokens: tokens,
            noData: false,
            isLoading: false,
            status: QueryTokenStatus.success));
      }
    } catch (e, s) {
      // emit(state.copyWith(status: QueryTokenStatus.error(e.toString())));
      emit(state.copyWith(
          tokens: [], status: QueryTokenStatus.error, isLoading: false));
      await SentryService().reportError(e, s);
    }
  }

  void reset() {
    emit(state.copyWith(
        keyword: null,
        tokens: [],
        status: QueryTokenStatus.initial,
        noData: false,
        isLoading: false));
  }

  void updateKeyword(String keyword) {
    emit(state.copyWith(keyword: keyword));
  }
}
