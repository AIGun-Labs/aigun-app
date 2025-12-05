import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/service_locator.dart';
import '../cubits/candle/candle_cubit.dart';
import '../cubits/index.dart';
import '../cubits/language/language_cubit.dart';
import '../cubits/options/option_cubit.dart';
import '../cubits/sound_effect/sound_effect_cubit.dart';

class GlobalProvide extends StatelessWidget {
  const GlobalProvide({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ThemeCubit>()),

        BlocProvider(create: (context) => getIt<SoundEffectCubit>()),

        BlocProvider(create: (context) => getIt<IntelCubit>()),
        BlocProvider(lazy: false, create: (context) => getIt<LanguageCubit>()),
        BlocProvider(create: (context) => getIt<TokenDetailCubit>()),
        BlocProvider(create: (context) => getIt<CandleCubit>()),
        BlocProvider(create: (context) => getIt<OptionsCubit>()),
      ],
      child: child,
    );
  }
}
