import 'package:flutter/material.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/add_token/add_token.dart';
import 'package:flutter_aigun/screens/auth/auth.dart';
import 'package:flutter_aigun/screens/switch_language/switch_language.dart';
import 'package:flutter_aigun/screens/tabbar/tabbar.dart';
import 'package:flutter_aigun/screens/receive_address/receive_address.dart';
import 'package:flutter_aigun/screens/select_network/select_network.dart';
import 'package:flutter_aigun/screens/send_confirm_again/send_confirm_again.dart';
import 'package:flutter_aigun/screens/send_select_token/send_select_token.dart';
import 'package:flutter_aigun/screens/send_token_detail/send_token_detail.dart';
import 'package:flutter_aigun/screens/send_token_state/send_token_state.dart';
import 'package:flutter_aigun/screens/trade/trade.dart';
import 'package:flutter_aigun/screens/trade_confirm/trade_confirm.dart';
import 'package:flutter_aigun/screens/trade_setting/trade_setting.dart';
import 'package:flutter_aigun/widgets/splash_screen.dart';
import 'package:go_router/go_router.dart';

enum TransitionType {
  rightToLeft,
  bottomToTop,
  fade,
}

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: _buildRoutes(),
  );

  static List<GoRoute> _buildRoutes() {
    return [
      _buildRoute(Routes.splash, const SplashScreen(),
          transitionType: TransitionType.fade),
      _buildRoute(Routes.home, const TabbarScreen(),
          transitionType: TransitionType.fade),
      _buildRoute(Routes.selectNetwork, const SelectNetworkScreen()),
      _buildRoute(Routes.receiveAddress, const ReceiveAddressScreen()),
      _buildRoute(Routes.sendSelectToken, const SendSelectTokenScreen()),
      _buildRoute(Routes.sendTokenDetail, const SendTokenDetailScreen()),
      _buildRoute(Routes.sendConfirmAgain, const SendConfirmAgainScreen()),
      _buildRoute(Routes.sendToken, const SendTokenStateScreen()),
      _buildRoute(Routes.addToken, const AddTokenScreen()),
      _buildRoute(Routes.login, const LoginScreen()),
      _buildRoute(Routes.tradeConfirm, const TradeConfirmScreen()),
      _buildRoute(Routes.trade, const TradeScreen()),
      _buildRoute(Routes.tradeSetting, const TradeSettingScreen()),
      _buildRoute(Routes.switchLanguage, const SwitchLanguageScreen()),
    ];
  }

  static GoRoute _buildRoute(String path, Widget screen,
      {List<GoRoute>? subRoutes,
      TransitionType transitionType = TransitionType.rightToLeft}) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: screen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (transitionType) {
              case TransitionType.rightToLeft:
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              case TransitionType.bottomToTop:
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              case TransitionType.fade:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
            }
          },
        );
      },
      routes: subRoutes ?? [],
    );
  }
}
