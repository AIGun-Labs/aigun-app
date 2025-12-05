part of 'app_routes.dart';

@TypedStatefulShellRoute<AppShellRoute>(
  branches: [
    TypedStatefulShellBranch<IntelBranch>(
      routes: [
        TypedGoRoute<IntelRoute>(
          path: RoutePaths.intel,
          name: RouteNames.intel,
        ),
      ],
    ),
    TypedStatefulShellBranch<TrendingBranch>(
      routes: [
        TypedGoRoute<TrendingRoute>(
          path: RoutePaths.trending,
          name: RouteNames.trending,
        ),
      ],
    ),
    TypedStatefulShellBranch<TradeBranch>(
      routes: [
        TypedGoRoute<TradeTabRoute>(
          path: RoutePaths.trade,
          name: RouteNames.trade,
        ),
      ],
    ),
    TypedStatefulShellBranch<BonusBranch>(
      routes: [
        TypedGoRoute<BonusRoute>(
          path: RoutePaths.bonus,
          name: RouteNames.bonus,
        ),
      ],
    ),
    TypedStatefulShellBranch<WalletBranch>(
      routes: [
        TypedGoRoute<WalletRoute>(
          path: RoutePaths.wallet,
          name: RouteNames.wallet,
        ),
      ],
    ),
  ],
)
final class AppShellRoute extends StatefulShellRouteData {
  const AppShellRoute();
  @override
  Widget builder(
    BuildContext c,
    GoRouterState s,
    StatefulNavigationShell shell,
  ) => HomeScreen(navigationShell: shell, gatekeeper: getIt());
}

final class IntelBranch extends StatefulShellBranchData {}

final class TrendingBranch extends StatefulShellBranchData {}

final class TradeBranch extends StatefulShellBranchData {}

final class BonusBranch extends StatefulShellBranchData {}

final class WalletBranch extends StatefulShellBranchData {}

final class IntelRoute extends SlideHRouteData with $IntelRoute {
  const IntelRoute();
  @override
  Widget buildPageChild(BuildContext context, GoRouterState state) =>
      const IntelScreen();
}

final class TrendingRoute extends SlideHRouteData with $TrendingRoute {
  const TrendingRoute();
  @override
  Widget buildPageChild(BuildContext context, GoRouterState state) =>
      const Center(child: Text("NO"));
}

final class TradeTabRoute extends SlideHRouteData with $TradeTabRoute {
  const TradeTabRoute();
  @override
  Widget buildPageChild(BuildContext context, GoRouterState state) =>
      const Center(child: Text("NO"));
}

final class BonusRoute extends SlideHRouteData with $BonusRoute {
  const BonusRoute();
  @override
  Widget buildPageChild(BuildContext context, GoRouterState state) =>
      const Center(child: Text("NO"));
}

final class WalletRoute extends SlideHRouteData with $WalletRoute {
  const WalletRoute();
  @override
  Widget buildPageChild(BuildContext context, GoRouterState state) =>
      const Center(child: Text("NO"));
}
