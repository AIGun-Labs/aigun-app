import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/sound_effect/sound_effect_cubit.dart';
import 'package:flutter_aigun/cubits/sound_effect/sound_effect_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundEffectCubit, SoundEffectState>(
        builder: (context, state) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<SoundEffectCubit>().playGunSound();
          },
          child: const Text("Play"),
        ),
      );
    });
  }
}
