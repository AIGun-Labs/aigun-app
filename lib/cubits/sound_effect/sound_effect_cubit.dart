import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/logger.dart';
import 'sound_effect_state.dart';

// TODO： 后续改成工具函数
class SoundEffectCubit extends Cubit<SoundEffectState> {
  SoundEffectCubit()
    : _gunSoundPlayer = AudioPlayer(),
      _gunLoadPlayer = AudioPlayer(),
      super(const SoundEffectState()) {
    init();
  }

  final AudioPlayer _gunSoundPlayer;
  final AudioPlayer _gunLoadPlayer;

  Future<void> init() async {
    await _configureAudioPlayers();
  }

  Future<void> _configureAudioPlayers() async {
    final audioContext = AudioContext(
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: const {AVAudioSessionOptions.mixWithOthers},
      ),
      android: const AudioContextAndroid(
        isSpeakerphoneOn: false,
        stayAwake: false,
        contentType: AndroidContentType.music,
        usageType: AndroidUsageType.game,
        audioFocus: AndroidAudioFocus.gain,
      ),
    );

    AudioPlayer.global.setAudioContext(audioContext);
  }

  Future<void> playGunSound() async {
    if (state.status == SoundEffectStatus.loading) return;
    try {
      emit(state.copyWith(status: SoundEffectStatus.loading));
      await _gunSoundPlayer.play(AssetSource('audio/gun_sound.mp3'));
      emit(state.copyWith(status: SoundEffectStatus.success));
    } catch (e) {
      Logger.error('play gun sound fail', e);
      emit(state.copyWith(status: SoundEffectStatus.error));
    }
  }

  Future<void> playGunLoad() async {
    if (state.status == SoundEffectStatus.loading) return;
    try {
      emit(state.copyWith(status: SoundEffectStatus.loading));
      await _gunLoadPlayer.play(AssetSource('audio/gun_load.mp3'));
      emit(state.copyWith(status: SoundEffectStatus.success));
    } catch (e) {
      Logger.error('playGundLoad');
      emit(state.copyWith(status: SoundEffectStatus.error));
    }
  }

  Future<void> playBonus() async {
    if (state.status == SoundEffectStatus.loading) return;
    try {
      emit(state.copyWith(status: SoundEffectStatus.loading));
      await _gunLoadPlayer.play(AssetSource('audio/bonus.mp3'));
      emit(state.copyWith(status: SoundEffectStatus.success));
    } catch (e) {
      Logger.error('playBonus');
      emit(state.copyWith(status: SoundEffectStatus.error));
    }
  }
}
