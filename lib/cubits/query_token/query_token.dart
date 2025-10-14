import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/cubits/query_token/query_token_state.dart';
import 'package:flutter_aigun/data/services/api/query_token.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QueryTokenCubit extends Cubit<QueryTokenState> {
  QueryTokenCubit() : super(const QueryTokenState());

  Future<void> queryToken(String keyword) async {
    if (keyword.isEmpty) {
      reset();
      return;
    }

    try {
      emit(state.copyWith(status: const QueryTokenStatus.loading()));
      final wallet = await getIt<WalletStorage>().getSelectedWallet();

      final tokens = await QueryTokenApi()
          .queryToken(keyWord: keyword, walletId: wallet?.id ?? '');

      if (tokens.isEmpty) {
        emit(state
            .copyWith(status: const QueryTokenStatus.noData(), tokens: []));
      } else {
        emit(state.copyWith(
            tokens: tokens, status: QueryTokenStatus.success(tokens)));
      }
    } catch (e, s) {
      // emit(state.copyWith(status: QueryTokenStatus.error(e.toString())));
      emit(state.copyWith(status: QueryTokenStatus.error(e.toString())));
      await SentryService().reportError(e, s);
    }
  }

  void reset() {
    emit(state.copyWith(tokens: [], status: const QueryTokenStatus.initial()));
  }
}
