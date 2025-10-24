import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_select_token_state.freezed.dart';

@freezed
class SendSelectTokenState with _$SendSelectTokenState {
  const factory SendSelectTokenState({
    @Default('') String searchKeyword,
    @Default([]) List<Token> filteredTokens,
  }) = _SendSelectTokenState;

  const SendSelectTokenState._();
}
