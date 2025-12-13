import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/service_locator.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/index.dart' hide SwapCubit;
import '../cubits/language/language_cubit.dart';
import '../cubits/options/option_cubit.dart';
import '../cubits/sound_effect/sound_effect_cubit.dart';
import '../features/candlestick/presentation/cubit/candlestick/candlestick_cubit.dart';
import '../features/candlestick/presentation/cubit/selection/selection_params_cubit.dart';
import '../features/chain/presentation/cubit/supported_chains_cubit.dart';
import '../features/collect/presentation/cubits/collect_cubit.dart';
import '../features/dynamic_tabs/presentation/cubits/dynamic_tabs/dynamic_tabs_cubit.dart';
import '../features/intelligence/presentation/cubits/intelligence/intelligence_cubit.dart';
import '../features/swap/presentation/cubit/swap/swap_cubit.dart';
import '../features/update/presentation/cubits/update_cubit.dart';

class GlobalProvide extends StatelessWidget {
  const GlobalProvide({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<QueryTokenCubit>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<SignUpCubit>()),
        BlocProvider(
          // lazy: false,
          create: (_) => getIt<UserCubit>(),
        ),
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<ForgotPasswordCubit>()),
        BlocProvider(create: (_) => getIt<SoundEffectCubit>()),
        BlocProvider(lazy: false, create: (_) => getIt<ChainCubit>()),
        BlocProvider(lazy: false, create: (_) => getIt<WalletCubit>()),
        BlocProvider(
          lazy: false, // BalanceCubit 需要立即初始化来监听 WalletCubit
          create: (_) => getIt<BalanceCubit>(),
        ),
        BlocProvider(create: (_) => getIt<TransferCubit>()),
        BlocProvider(create: (_) => getIt<IntelCubit>()),
        BlocProvider(lazy: false, create: (_) => getIt<LanguageCubit>()),
        BlocProvider(create: (_) => getIt<TradeCubit>()),
        BlocProvider(create: (_) => getIt<TradeSettingCubit>()),
        BlocProvider(create: (_) => getIt<SearchTokenCubit>()),
        BlocProvider(create: (_) => getIt<QuickTradeCubit>()),
        BlocProvider(create: (_) => getIt<CollectCubit>()),
        BlocProvider(create: (_) => getIt<UpdateCubit>()),
        BlocProvider(lazy: false, create: (_) => getIt<OptionsCubit>()),
        BlocProvider(create: (_) => getIt<SwapCubit>()),
        BlocProvider(lazy: false, create: (_) => getIt<SupportedChainsCubit>()),
        BlocProvider(create: (_) => getIt<IntelligenceCubit>()),
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<SelectionParamsCubit>()),
        BlocProvider(create: (_) => getIt<CandlestickCubit>()),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<DynamicTabsCubit>(),
        ),
      ],
      child: child,
    );
  }
}
