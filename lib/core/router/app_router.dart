import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// import '../../shared/presentation/cubits/new_user/new_user_cubit.dart';
// import '../service_locator.dart';
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
  static final AnalyticsRouteObserver _analyticsObserver =
      AnalyticsRouteObserver();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.intel,
    // refreshListenable: GoRouterRefreshStream(
    //   getIt<NewUserCubit>().stream,
    // ),
    debugLogDiagnostics: true,
    observers: [_analyticsObserver], //
    redirect: (context, state) {
      if (state.uri.toString().contains(RoutePaths.webviewPreview)) {
        return null;
      }
      if (state.uri.toString() == RoutePaths.splash ||
          state.uri.toString() == RoutePaths.login) {
        return RoutePaths.intel;
      }

      return null;
    },
    routes: $appRoutes,
    errorBuilder: (context, state) =>
        ErrorPage(error: state.error?.toString() ?? 'Unknown error'),
  );
}

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
