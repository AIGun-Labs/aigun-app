import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aigun/data/services/permissions_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';
import 'package:flutter_aigun/cubits/language/language_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/global_provide.dart';
import 'package:flutter_aigun/widgets/unfocus.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import 'core/router/app_router.dart';

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
  @override
  void initState() {
    super.initState();
    // 在 widget 构建完成后执行
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => PermissionsService.requestTrackingPermission(context));
  }

  @override
  Widget build(BuildContext context) {
    return GlobalProvide(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, languageState) {
              return ScreenUtilInit(
                designSize: const Size(393, 852),
                builder: (context, child) {
                  return Unfocus(
                    child: ToastificationWrapper(
                      config: const ToastificationConfig(
                        alignment: Alignment.topCenter,
                      ),
                      child: AnnotatedRegion(
                        value: SystemUiOverlayStyle(
                          statusBarColor: AppColors.background(context),
                          statusBarIconBrightness: Brightness.dark,
                          systemNavigationBarColor:
                              AppColors.background(context),
                          systemNavigationBarIconBrightness: Brightness.dark,
                        ),
                        child: MaterialApp.router(
                          scaffoldMessengerKey: scaffoldMessengerKey,
                          title: 'AIGun',
                          locale: languageState.locale,
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
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
