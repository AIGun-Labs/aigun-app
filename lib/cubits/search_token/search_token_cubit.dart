import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/search_token/search_token_state.dart';
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
      final tokens = await tokenApi.searchTokens(keyword);

      final filterTokens = tokens.take(20).toList();

      emit(
        state.copyWith(
          matchedTokens: filterTokens, status: SearchTokenStatus.success));

      final nativeTokens = filterTokens;
      tradeCubit.emit(tradeCubit.state.copyWith(nativeTokens: nativeTokens));
    } catch (e) {
      showSimpleToast("接口抛出错误: ${e.toString()}");
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
