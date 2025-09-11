import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/trade/trade_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';

import '../screens/intel/cubit_back/intel_data_cubit.dart';

class GlobalProvide extends StatelessWidget {
  const GlobalProvide({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ThemeCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<SignUpCubit>(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ForgotPasswordCubit>(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<ChainCubit>(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<WalletCubit>(),
        ),
        BlocProvider(
          lazy: false,
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
        BlocProvider(
          create: (context) => getIt<IntelDataCubit>(),
        ),
        BlocProvider(create: (context) => getIt<IntelCubit>()),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<LanguageCubit>(),
        ),
        BlocProvider(create: (context) => getIt<TradeCubit>()),
        BlocProvider(create: (context) => getIt<TradeSettingCubit>()),
        BlocProvider(create: (context) => getIt<SearchTokenCubit>()),
        BlocProvider(create: (context) => getIt<QuickTradeCubit>())
      ],
      child: child,
    );
  }
}
