import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/service_locator.dart';
import '../../../cubits/balance/balance_cubit.dart';
import '../../../data/models/wallet/token/token.dart';
import '../../../data/services/sentry_service.dart';
import 'send_select_token_state.dart';

class SendSelectTokenCubit extends Cubit<SendSelectTokenState> {
  SendSelectTokenCubit() : super(const SendSelectTokenState());

  void updateKeyword(String keyword) {
    emit(SendSelectTokenState(
      searchKeyword: keyword,
    ));
  }

  List<Token>? getTokens(List<Token>? addressList) {
    if (state.searchKeyword.isEmpty || addressList == null) {
      return addressList;
    }

    return addressList.where((token) {
      return token.symbol.contains(state.searchKeyword);
    }).toList();
  }

  Future<void> filterTokens(String keyword) async {
    try {
      final tokens = getIt
          .call<BalanceCubit>()
          .state
          .balances
          ?.tokens
          .where((token) => token.tokenName.contains(keyword))
          .toList();
      emit(state.copyWith(filteredTokens: tokens ?? []));
    } catch (e, s) {
      await SentryService().reportError(e, s,
          tags: {"feature": "filterTokens"}, extra: {"keyword": keyword});
    }
  }
}
