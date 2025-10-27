import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/auth/auth_cubit.dart';
import 'package:flutter_aigun/cubits/candle/candle_cubit.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_cubit.dart';
import 'package:flutter_aigun/cubits/latest_token/latest_token_cubit.dart';
import 'package:flutter_aigun/cubits/network/network_cubit.dart';
import 'package:flutter_aigun/cubits/sound_effect/sound_effect_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';

import '../features/update/presentation/cubit/update_cubit.dart';

class GlobalProvide extends StatelessWidget {
  const GlobalProvide({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<QueryTokenCubit>()),
        BlocProvider(
          create: (context) => getIt<ThemeCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<SignUpCubit>(),
        ),
        BlocProvider(
          // lazy: false,
          create: (context) => getIt<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ForgotPasswordCubit>(),
        ),
        BlocProvider(create: (context) => getIt<SoundEffectCubit>()),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<ChainCubit>(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<WalletCubit>(),
        ),
        BlocProvider(
          lazy: false, // BalanceCubit 需要立即初始化来监听 WalletCubit
          create: (context) => getIt<BalanceCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<TransferCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<MonitorGroupCubit>()..fetchMonitorGroupList(),
        ),
        BlocProvider(
          create: (context) => getIt<MonitorCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<SwapCubit>(),
        ),
        BlocProvider(create: (context) => getIt<IntelCubit>()),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<LanguageCubit>(),
        ),
        BlocProvider(create: (context) => getIt<TrendingCubit>()),
        BlocProvider(create: (context) => getIt<TradeCubit>()),
        BlocProvider(create: (context) => getIt<TradeSettingCubit>()),
        BlocProvider(create: (context) => getIt<SearchTokenCubit>()),
        BlocProvider(create: (context) => getIt<QuickTradeCubit>()),
        BlocProvider(create: (context) => getIt<TokenDetailCubit>()),
        BlocProvider(create: (context) => getIt<FavoriteTokenCubit>()),
        BlocProvider(create: (context) => getIt<LatestTokenCubit>()),
        BlocProvider(create: (context) => getIt<UpdateCubit>()),
        BlocProvider(create: (context) => getIt<CandleCubit>()),
        BlocProvider(create: (context) => getIt<NetworkCubit>()),
      ],
      child: child,
    );
  }
}
