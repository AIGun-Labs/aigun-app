import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/app_router.dart';
import 'package:flutter_aigun/themes/theme.dart';
import 'package:flutter_aigun/widgets/global_provide.dart';
import 'package:flutter_aigun/widgets/unfocus.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class AIGunApp extends StatefulWidget {
  const AIGunApp({super.key});

  @override
  AIGunAppState createState() => AIGunAppState();

  static AIGunAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<AIGunAppState>();
}

class AIGunAppState extends State<AIGunApp> {
  Locale _locale = const Locale('zh');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalProvide(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return ScreenUtilInit(
            designSize: const Size(393, 852),
            builder: (context, child) {
              return Unfocus(
                child: ToastificationWrapper(
                  config: const ToastificationConfig(
                    alignment: Alignment.topCenter,
                  ),
                  child: MaterialApp.router(
                    scaffoldMessengerKey: scaffoldMessengerKey,
                    title: 'AIGun',
                    locale: _locale,
                    routerConfig: AppRouter.router,
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en', "US"),
                      Locale('zh', "CN"),
                    ],
                    theme: AppTheme.buildLightTheme(),
                    darkTheme: AppTheme.buildDarkTheme(),
                    // themeMode: context.read<ThemeCubit>().flutterThemeMode,
                    themeMode: ThemeMode.light,
                    debugShowCheckedModeBanner: false,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
