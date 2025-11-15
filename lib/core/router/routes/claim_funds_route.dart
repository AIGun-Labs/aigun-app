part of '../app_routes.dart';

@TypedGoRoute<ClaimFundsRoute>(
    path: RoutePaths.claimFunds, name: RouteNames.claimFunds)
class ClaimFundsRoute extends GoRouteData {
  const ClaimFundsRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) => CupertinoPage(
      child: BlocProvider(
          create: (context) => getIt<ClaimTokenCubit>()..init(),
          child: const ClaimFundsScreen()));
}
