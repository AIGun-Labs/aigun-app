import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/service_locator.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/candle/candle_cubit.dart';
import '../cubits/index.dart';
import '../cubits/language/language_cubit.dart';
import '../cubits/network/network_cubit.dart';
import '../cubits/options/option_cubit.dart';
import '../cubits/sound_effect/sound_effect_cubit.dart';
import '../features/collect/presentation/cubits/collect_cubit.dart';
import '../features/update/presentation/cubits/update_cubit.dart';

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
        BlocProvider(create: (context) => getIt<CollectCubit>()),
        BlocProvider(create: (context) => getIt<UpdateCubit>()),
        BlocProvider(create: (context) => getIt<CandleCubit>()),
        BlocProvider(lazy: false, create: (context) => getIt<NetworkCubit>()),
        BlocProvider(create: (context) => getIt<OptionsCubit>()),
      ],
      child: child,
    );
  }
}
