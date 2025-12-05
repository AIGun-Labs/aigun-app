import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/logger.dart';
import 'sound_effect_state.dart';

class SoundEffectCubit extends Cubit<SoundEffectState> {
  late final AudioPlayer _gunSoundPlayer;
  late final AudioPlayer _gunLoadPlayer;

  // SoundEffectCubit()
  //     : _audioPlayer = AudioPlayer(),
  //       super(const SoundEffectState());

  SoundEffectCubit() : super(const SoundEffectState()) {
    _gunSoundPlayer = AudioPlayer();
    _gunLoadPlayer = AudioPlayer();
    _configureAudioPlayers();
  }

  Future<void> _configureAudioPlayers() async {
    final audioContext = AudioContext(
        iOS: AudioContextIOS(
            category: AVAudioSessionCategory.playback,
            options: const {AVAudioSessionOptions.mixWithOthers}),
        android: const AudioContextAndroid(
            isSpeakerphoneOn: false,
            stayAwake: false,
            contentType: AndroidContentType.music,
            usageType: AndroidUsageType.game,
            audioFocus: AndroidAudioFocus.gain));

    AudioPlayer.global.setAudioContext(audioContext);
  }

  Future<void> playGunSound() async {
    if (state.status == SoundEffectStatus.loading) return;
    try {
      emit(state.copyWith(status: SoundEffectStatus.loading));
      await _gunSoundPlayer.play(AssetSource("audio/gun_sound.mp3"));
      emit(state.copyWith(status: SoundEffectStatus.success));
    } catch (e) {
      Logger.error("play gun sound fail", e);
      emit(state.copyWith(status: SoundEffectStatus.error));
    }
  }

  Future<void> playGunLoad() async {
    if (state.status == SoundEffectStatus.loading) return;
    try {
      emit(state.copyWith(status: SoundEffectStatus.loading));
      await _gunLoadPlayer.play(AssetSource("audio/gun_load.mp3"));
      emit(state.copyWith(status: SoundEffectStatus.success));
    } catch (e) {
      Logger.error("playGundLoad");
      emit(state.copyWith(status: SoundEffectStatus.error));
    }
  }
}
