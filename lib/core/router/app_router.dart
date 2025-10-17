import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/services/firebase_analytics_service.dart';
import '../../features/home/presentation/pages/home.dart';
import '../../screens/add_token/add_token.dart';
import '../../screens/auth/auth.dart';
import '../../screens/intel/intel.dart';
import '../../screens/invite/invite.dart';
import '../../screens/query_token/query_token.dart';
import '../../screens/receive_address/receive_address.dart';
import '../../screens/select_network/select_network.dart';
import '../../screens/send_confirm_again/send_confirm_again.dart';
import '../../screens/send_select_token/send_select_token.dart';
import '../../screens/send_token_detail/send_token_detail.dart';
import '../../screens/send_token_state/send_token_state.dart';
import '../../screens/switch_language/switch_language.dart';
import '../../screens/token_detail/token_detail.dart';
import '../../screens/trade/trade.dart';
import '../../screens/trade_confirm/trade_confirm.dart';
import '../../screens/trade_setting/trade_setting.dart';
import '../../screens/trending/trending.dart';
import '../../screens/wallet/wallet.dart';
import '../../widgets/splash_screen.dart';
import '../service_locator.dart';
import 'constants.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    observers: [
      getIt<AnalyticsService>().getAnalyticsObserver(),
    ],
    routes: [
      _buildRoute(RoutePaths.splash, RouteNames.splash, const SplashScreen(),
          transitionType: TransitionType.fade),
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return HomeScreen(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(routes: [
              _buildRoute(
                  RoutePaths.intel, RouteNames.intel, const IntelScreen())
            ]),
            StatefulShellBranch(routes: [
              _buildRoute(RoutePaths.trending, RouteNames.trending,
                  const TrendingScreen())
            ]),
            StatefulShellBranch(routes: [
              _buildRoute(
                  RoutePaths.trade, RouteNames.trade, const TradeScreen())
            ]),
            StatefulShellBranch(routes: [
              _buildRoute(
                  RoutePaths.invite, RouteNames.invite, const InviteScreen())
            ]),
            StatefulShellBranch(routes: [
              _buildRoute(
                  RoutePaths.wallet, RouteNames.wallet, const WalletScreen())
            ]),
          ]),
      //     transitionType: TransitionType.fade),
      _buildRoute(RoutePaths.selectNetwork, RouteNames.selectNetwork,
          const SelectNetworkScreen()),
      _buildRoute(RoutePaths.receiveAddress, RouteNames.receiveAddress,
          const ReceiveAddressScreen()),
      _buildRoute(RoutePaths.sendSelectToken, RouteNames.sendSelectToken,
          const SendSelectTokenScreen()),
      _buildRoute(RoutePaths.sendTokenDetail, RouteNames.sendTokenDetail,
          const SendTokenDetailScreen()),
      _buildRoute(RoutePaths.sendConfirmAgain, RouteNames.sendConfirmAgain,
          const SendConfirmAgainScreen()),
      _buildRoute(RoutePaths.sendToken, RouteNames.sendToken,
          const SendTokenStateScreen()),
      _buildRoute(
          RoutePaths.addToken, RouteNames.addToken, const AddTokenScreen()),
      _buildRoute(RoutePaths.login, RouteNames.login, const LoginScreen()),
      _buildRoute(RoutePaths.tradeConfirm, RouteNames.tradeConfirm,
          const TradeConfirmScreen()),
      _buildRoute(RoutePaths.tradeSetting, RouteNames.tradeSetting,
          const TradeSettingScreen()),
      _buildRoute(RoutePaths.switchLanguage, RouteNames.switchLanguage,
          const SwitchLanguageScreen()),
      _buildRoute(RoutePaths.tokenDetail, RouteNames.tokenDetail,
          const TokenDetailScreen()),
      _buildRoute(RoutePaths.searchInternal, RouteNames.searchInternal,
          const QueryTokenScreen()),
    ],
    // 错误页面处理
    errorBuilder: (context, state) =>
        ErrorPage(error: state.error?.toString() ?? 'Unknown error'),
  );
}

enum TransitionType {
  rightToLeft,
  bottomToTop,
  fade,
}

GoRoute _buildRoute(String path, String name, Widget screen,
    {List<GoRoute>? routes,
    TransitionType transitionType = TransitionType.rightToLeft}) {
  return GoRoute(
    path: path,
    name: name,
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
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            case TransitionType.bottomToTop:
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
    routes: routes ?? [],
  );
}

// 错误页面
class ErrorPage extends StatelessWidget {
  final String error;

  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error'), backgroundColor: Colors.red),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              error,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.goNamed(RouteNames.intel),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
