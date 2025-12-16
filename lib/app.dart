import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import 'core/router/app_router.dart';
import 'core/service_locator.dart';
import 'data/services/permissions_service.dart';
import 'features/language/presentation/controllers/locale_controller.dart';
import 'l10n/l10n.dart';
import 'themes/themes.dart';
import 'widgets/global_provide.dart';
import 'widgets/unfocus.dart';

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
      (_) => PermissionsService.requestTrackingPermission(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localeController = getIt<LocaleController>();

    return GlobalProvide(
      child: ScreenUtilInit(
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
                  systemNavigationBarColor: AppColors.background(context),
                  systemNavigationBarIconBrightness: Brightness.dark,
                ),
                child: ListenableBuilder(
                  listenable: localeController,
                  builder: (BuildContext context, _) {
                    return MaterialApp.router(
                      scaffoldMessengerKey: scaffoldMessengerKey,
                      title: 'AIGun',
                      routerConfig: AppRouter.router,
                      locale: localeController.followSystem
                          ? null
                          : localeController.appLocale,
                      localizationsDelegates: S.localizationsDelegates,
                      supportedLocales: S.supportedLocales,
                      theme: AppTheme.buildLightTheme(),
                      darkTheme: AppTheme.buildDarkTheme(),
                      themeMode: ThemeMode.light,
                      debugShowCheckedModeBanner: false,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
