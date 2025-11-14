import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/features/bonus/domain/usecases/claim_token.dart';
import 'package:flutter_aigun/features/bonus/domain/usecases/fetch_active_code.dart';
import 'package:flutter_aigun/features/bonus/domain/usecases/fetch_claim_gold.dart';
import 'package:flutter_aigun/features/bonus/domain/usecases/fetch_invite_info.dart';
import 'package:flutter_aigun/features/bonus/domain/usecases/fetch_realtime_funds.dart';
import 'package:flutter_aigun/features/bonus/domain/usecases/unclaimed_tokens.dart';
import 'package:flutter_aigun/features/bonus/presentation/cubits/claim_token_cubit.dart';
import 'package:flutter_aigun/screens/webview/webview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cubits/ai_agent/ai_agent_cubit.dart';
import '../../features/ai_agent/presentation/pages/ai_agent.dart';
import '../../features/bonus/presentation/cubits/invite_cubit.dart';
import '../../features/bonus/presentation/pages/bonus.dart';
import '../../features/bonus/presentation/pages/claim_funds.dart';
import '../../features/home/presentation/pages/home.dart';
import '../../features/trending/presentation/pages/trending.dart';
import '../../screens/add_token/add_token.dart';
import '../../screens/auth/auth.dart';
import '../../screens/intel/intel.dart';
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
import '../../screens/wallet/wallet.dart';
import '../../widgets/splash_screen.dart';
import '../service_locator.dart';
import 'analytics_route_observer.dart';
import 'constants.dart';

class AppRouter {
  // 路由分析观察者
  static final AnalyticsRouteObserver _analyticsObserver =
      AnalyticsRouteObserver();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    observers: [_analyticsObserver], // 添加路由观察者
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
              _buildRoute(
                  RoutePaths.trending,
                  RouteNames.trending,
                  BlocProvider(
                    create: (context) => getIt<AiAgentCubit>(),
                    child: const TrendingScreen(),
                  ))
            ]),
            StatefulShellBranch(routes: [
              _buildRoute(
                  RoutePaths.trade, RouteNames.trade, const TradeScreen())
            ]),
            StatefulShellBranch(routes: [
              _buildRoute(
                RoutePaths.bonus,
                RouteNames.bonus,
                BlocProvider(
                  create: (context) => InviteCubit(
                    getIt<FetchRealtimeFunds>(),
                    getIt<FetchInviteInfo>(),
                    getIt<FetchActiveCode>(),
                    getIt<FetchClaimGold>(),
                  ),
                  child: const BonusScreen(),
                ),
              )
            ]),
            StatefulShellBranch(routes: [
              _buildRoute(
                  RoutePaths.wallet, RouteNames.wallet, const WalletScreen())
            ]),
          ]),
      //     transitionType: TransitionType.fade),
      _buildRoute(RoutePaths.selectNetwork, RouteNames.selectNetwork,
          const SelectNetworkScreen(),
          isCupertino: true),
      _buildRoute(RoutePaths.receiveAddress, RouteNames.receiveAddress,
          const ReceiveAddressScreen(),
          isCupertino: true),
      _buildRoute(RoutePaths.sendSelectToken, RouteNames.sendSelectToken,
          const SendSelectTokenScreen(),
          isCupertino: true),
      _buildRoute(RoutePaths.sendTokenDetail, RouteNames.sendTokenDetail,
          const SendTokenDetailScreen(),
          isCupertino: true),
      _buildRoute(RoutePaths.sendConfirmAgain, RouteNames.sendConfirmAgain,
          const SendConfirmAgainScreen(),
          isCupertino: true),
      _buildRoute(RoutePaths.sendToken, RouteNames.sendToken,
          const SendTokenStateScreen(),
          isCupertino: true),
      _buildRoute(RoutePaths.webviewPreview, RouteNames.webviewPreview,
          const WebviewScreen(),
          isCupertino: true),
      _buildRoute(
          RoutePaths.addToken, RouteNames.addToken, const AddTokenScreen(),
          isCupertino: true),
      _buildRoute(RoutePaths.login, RouteNames.login, const LoginScreen(),
          isCupertino: true),
      _buildRoute(RoutePaths.tradeConfirm, RouteNames.tradeConfirm,
          const TradeConfirmScreen(),
          isCupertino: true),
      _buildRoute(RoutePaths.tradeSetting, RouteNames.tradeSetting,
          const TradeSettingScreen(),
          isCupertino: true),
      _buildRoute(RoutePaths.switchLanguage, RouteNames.switchLanguage,
          const SwitchLanguageScreen(),
          isCupertino: true),
      _buildRoute(RoutePaths.tokenDetail, RouteNames.tokenDetail,
          const TokenDetailScreen(),
          isCupertino: true),
      _buildRoute(RoutePaths.searchInternal, RouteNames.searchInternal,
          const QueryTokenScreen(),
          isCupertino: true),

      _buildRoute(
          RoutePaths.aiAgent,
          RouteNames.aiAgent,
          BlocProvider(
            create: (context) => getIt<AiAgentCubit>(),
            child: const AiAgentScreen(),
          )),

      GoRoute(
        path: RoutePaths.claimFunds,
        name: RouteNames.claimFunds,
        pageBuilder: (context, state) => CupertinoPage(
            child: BlocProvider(
          create: (context) => ClaimTokenCubit(
            getIt<UnclaimedTokens>(),
            getIt<ClaimToken>(),
          )..init(),
          child: const ClaimFundsScreen(),
        )),
      )
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
    bool isCupertino = false,
    TransitionType transitionType = TransitionType.rightToLeft}) {
  return isCupertino
      ? GoRoute(
          path: path,
          name: name,
          pageBuilder: (context, state) => CupertinoPage(child: screen),
        )
      : GoRoute(
          path: path,
          name: name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: screen,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
