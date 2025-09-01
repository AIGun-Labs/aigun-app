import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:flutter_aigun/screens/send_select_token/cubit/send_select_token_state.dart';

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
}
