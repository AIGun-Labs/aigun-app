import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'analytics_route_observer.dart';
import 'constants.dart';
import 'routes/app_routes.dart';

class AppRouter {
  // 路由分析观察者
  static final AnalyticsRouteObserver _analyticsObserver =
      AnalyticsRouteObserver();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    observers: [_analyticsObserver], // 添加路由观察者
    routes: $appRoutes,
    // 错误页面处理
    errorBuilder: (context, state) =>
        ErrorPage(error: state.error?.toString() ?? 'Unknown error'),
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
