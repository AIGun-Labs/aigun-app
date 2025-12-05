import "package:freezed_annotation/freezed_annotation.dart";

part "validator_state.freezed.dart";

@freezed
class ValidatorState with _$ValidatorState {
  const factory ValidatorState.initial() = _Initial;
  const factory ValidatorState.valid() = _Valid;
  const factory ValidatorState.invalid() = _Invalid;
}
