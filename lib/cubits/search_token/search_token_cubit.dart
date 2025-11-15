import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../../data/services/api/token_api.dart';
import '../../data/services/sentry_service.dart';
import '../../utils/storage/local/wallet_storage.dart';
import '../index.dart';

class SearchTokenCubit extends Cubit<SearchTokenState> {
  SearchTokenCubit(this.tokenApi, this.tradeCubit)
      : super(const SearchTokenState());

  final TokenApi tokenApi;
  final TradeCubit tradeCubit;

  void updateSearchKeyword(String searchKeyword) {
    emit(state.copyWith(searchKeyword: searchKeyword));
  }

  Future<void> searchTokenByKeyword(String keyword) async {
    emit(state.copyWith(status: SearchTokenStatus.loading));
    final wallet = await getIt<WalletStorage>().getSelectedWallet();

    try {
      final tokens = await tokenApi.searchTokens(keyword, wallet?.id);

      final filterTokens = tokens.take(20).toList();

      emit(state.copyWith(
          matchedTokens: filterTokens, status: SearchTokenStatus.success));

      // final nativeTokens = filterTokens;
      // tradeCubit.emit(tradeCubit.state.copyWith(nativeTokens: nativeTokens));
    } catch (e, s) {
      emit(state.copyWith(matchedTokens: [], status: SearchTokenStatus.error));
      await SentryService().reportError(e, s,
          tags: {"feature": "searchTokenByKeyword"},
          extra: {"keyword": keyword, "walletId": wallet?.id});
    }
  }

  void clear() {
    emit(state.copyWith(
        matchedTokens: [],
        status: SearchTokenStatus.initial,
        searchKeyword: ''));
  }
}
