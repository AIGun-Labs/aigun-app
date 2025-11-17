part of 'app_routes.dart';

@TypedStatefulShellRoute<AppShellRoute>(
  branches: [
    TypedStatefulShellBranch<IntelBranch>(routes: [
      TypedGoRoute<IntelRoute>(path: RoutePaths.intel, name: RouteNames.intel)
    ]),
    TypedStatefulShellBranch<TrendingBranch>(routes: [
      TypedGoRoute<TrendingRoute>(
          path: RoutePaths.trending, name: RouteNames.trending)
    ]),
    TypedStatefulShellBranch<TradeBranch>(routes: [
      TypedGoRoute<TradeTabRoute>(
          path: RoutePaths.trade, name: RouteNames.trade)
    ]),
    TypedStatefulShellBranch<BonusBranch>(routes: [
      TypedGoRoute<BonusRoute>(path: RoutePaths.bonus, name: RouteNames.bonus)
    ]),
    TypedStatefulShellBranch<WalletBranch>(routes: [
      TypedGoRoute<WalletRoute>(
          path: RoutePaths.wallet, name: RouteNames.wallet)
    ]),
  ],
)
class AppShellRoute extends StatefulShellRouteData {
  const AppShellRoute();
  @override
  Widget builder(
          BuildContext c, GoRouterState s, StatefulNavigationShell shell) =>
      HomeScreen(navigationShell: shell);
}

class IntelBranch extends StatefulShellBranchData {}

class TrendingBranch extends StatefulShellBranchData {}

class TradeBranch extends StatefulShellBranchData {}

class BonusBranch extends StatefulShellBranchData {}

class WalletBranch extends StatefulShellBranchData {}

class IntelRoute extends GoRouteData {
  const IntelRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      slideH(const IntelScreen());
}

class TrendingRoute extends GoRouteData {
  const TrendingRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) => slideH(BlocProvider(
      create: (_) => getIt<AiAgentCubit>(), child: const TrendingScreen()));
}

class TradeTabRoute extends GoRouteData {
  const TradeTabRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      slideH(const TradeScreen());
}

class BonusRoute extends GoRouteData {
  const BonusRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) => slideH(BlocProvider(
      create: (context) => getIt<InviteCubit>(), child: const BonusScreen()));
}

class WalletRoute extends GoRouteData {
  const WalletRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      slideH(const WalletScreen());
}
