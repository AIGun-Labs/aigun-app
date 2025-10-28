import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/features/bonus/presentation/pages/claim_funds.dart';
import 'package:flutter_aigun/screens/webview/webview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cubits/ai_agent/ai_agent_cubit.dart';
import '../../features/ai_agent/presentation/pages/ai_agent.dart';
import '../../features/bonus/presentation/pages/bonus.dart';
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
import 'constants.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    // redirect: (context, state) {
    //   final userCubit = getIt<UserCubit>();
    //   final isLoggedIn = userCubit.state.isLoggedIn;
    //   final isLoading = userCubit.state.isLoading;
    //   // 如果正在加载用户状态，保持当前页面
    //   if (isLoading) {
    //     return null;
    //   }

    //   // 不需要登录的页面列表
    //   final publicPaths = [
    //     RoutePaths.splash,
    //     RoutePaths.login,
    //     RoutePaths.intel, // IntelScreen 不需要登录
    //   ];

    //   final currentPath = state.uri.path;
    //   final isPublicPath = publicPaths.contains(currentPath);

    //   // 如果用户未登录且访问的不是公开页面，重定向到登录页
    //   if (!isLoggedIn && !isPublicPath) {
    //     return RoutePaths.login;
    //   }

    //   // 如果用户已登录且在登录页，重定向到钱包页面
    //   if (isLoggedIn && currentPath == RoutePaths.login) {
    //     return RoutePaths.wallet;
    //   }

    //   return null; // 不需要重定向
    // },
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
                const BonusScreen(),
              )
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
      _buildRoute(RoutePaths.webviewPreview, RouteNames.webviewPreview,
          const WebviewScreen()),
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
        pageBuilder: (context, state) =>
            const CupertinoPage(child: ClaimFundsScreen()),
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
