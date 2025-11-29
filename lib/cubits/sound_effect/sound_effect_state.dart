import 'package:freezed_annotation/freezed_annotation.dart';

part 'sound_effect_state.freezed.dart';

enum SoundEffectStatus { initial, loading, success, error }

@freezed
sealed class SoundEffectState with _$SoundEffectState {
  const factory SoundEffectState({
    @Default(SoundEffectStatus.initial) SoundEffectStatus status,
  }) = _SoundEffectState;
}
