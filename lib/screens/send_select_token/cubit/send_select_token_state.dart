import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/wallet/token/token.dart';

part 'send_select_token_state.freezed.dart';

@freezed
sealed class SendSelectTokenState with _$SendSelectTokenState {
  const factory SendSelectTokenState({
    @Default('') String searchKeyword,
    @Default([]) List<Token> filteredTokens,
  }) = _SendSelectTokenState;

  const SendSelectTokenState._();
}
