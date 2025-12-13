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
        TypedGoRoute<TradeRoute>(
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
  Widget buildPageChild(BuildContext context, GoRouterState state) {
    // Use feature flag to switch between old and new intelligence implementations
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<IntelligenceCubit>()),
        BlocProvider(create: (_) => getIt<EventListCubit>()),
        BlocProvider(create: (_) => getIt<SignalListCubit>()),
        BlocProvider(create: (_) => getIt<UnreadCubit>()),
      ],
      child: const IntelligencePage(),
    );
  }
}

final class TrendingRoute extends SlideHRouteData with $TrendingRoute {
  const TrendingRoute();
  @override
  Widget buildPageChild(BuildContext context, GoRouterState state) {
    return const NewTrendingScreen();
  }
}

final class TradeRoute extends SlideHRouteData with $TradeRoute {
  const TradeRoute();
  @override
  Widget buildPageChild(BuildContext context, GoRouterState state) =>
      const SwapScreen();
}

final class BonusRoute extends SlideHRouteData with $BonusRoute {
  const BonusRoute();
  @override
  Widget buildPageChild(BuildContext context, GoRouterState state) =>
      BlocProvider(
        create: (context) => getIt<InviteCubit>(),
        child: const BonusScreen(),
      );
}

final class WalletRoute extends SlideHRouteData with $WalletRoute {
  const WalletRoute();
  @override
  Widget buildPageChild(BuildContext context, GoRouterState state) =>
      const WalletScreen();
}
