import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../shared/presentation/cubits/new_user/new_user_cubit.dart';
import '../service_locator.dart';
import 'analytics_route_observer.dart';
import 'constants.dart';
import 'routes/app_routes.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }
  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  // 路由分析观察者
  static final AnalyticsRouteObserver _analyticsObserver =
      AnalyticsRouteObserver();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splash,
    refreshListenable: GoRouterRefreshStream(
      getIt<NewUserCubit>().stream,
    ), // 刷新用户状态
    debugLogDiagnostics: true,
    observers: [_analyticsObserver], // 添加路由观察者
    redirect: (context, state) {
      final userState = BlocProvider.of<NewUserCubit>(context).state;

      if (state.uri.toString().contains(RoutePaths.webviewPreview)) {
        return null;
      }

      // 如果用户已登录，则不能访问登录页面
      if (userState.authStatus == AuthStatus.authenticated &&
          state.uri.toString() == RoutePaths.login) {
        return RoutePaths.intel;
      }

      // 如果用户未登录，则不能访问除情报页面和首页外的其他页面
      if (userState.authStatus == AuthStatus.unauthenticated &&
          (state.uri.toString() != RoutePaths.intel &&
              state.uri.toString() != RoutePaths.splash)) {
        return RoutePaths.login;
      }
      return null;
    },
    routes: $appRoutes,
    // 错误页面处理
    errorBuilder: (context, state) =>
        ErrorPage(error: state.error?.toString() ?? 'Unknown error'),
  );
}

// 错误页面
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});
  final String error;

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
