import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/data/services/api/token_api.dart';

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

    try {
      final wallet = await getIt<WalletStorage>().getSelectedWallet();

      final tokens = await tokenApi.searchTokens(keyword, wallet?.id);

      final filterTokens = tokens.take(20).toList();

      emit(state.copyWith(
          matchedTokens: filterTokens, status: SearchTokenStatus.success));

      // final nativeTokens = filterTokens;
      // tradeCubit.emit(tradeCubit.state.copyWith(nativeTokens: nativeTokens));
    } catch (e) {
      emit(state.copyWith(matchedTokens: [], status: SearchTokenStatus.error));
    }
  }

  void clear() {
    emit(state.copyWith(
        matchedTokens: [],
        status: SearchTokenStatus.initial,
        searchKeyword: ''));
  }
}
