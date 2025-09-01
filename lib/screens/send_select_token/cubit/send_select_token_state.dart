import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_select_token_state.freezed.dart';

@freezed
class SendSelectTokenState with _$SendSelectTokenState {
  const factory SendSelectTokenState({
    @Default('') String searchKeyword,
  }) = _SendSelectTokenState;

  const SendSelectTokenState._();
}
