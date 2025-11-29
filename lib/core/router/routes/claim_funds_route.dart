part of 'app_routes.dart';

@TypedGoRoute<ClaimFundsRoute>(
  path: RoutePaths.claimFunds,
  name: RouteNames.claimFunds,
)
class ClaimFundsRoute extends GoRouteData with $ClaimFundsRoute {
  const ClaimFundsRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) => CupertinoPage(
    child: BlocProvider(
      create:
          (context) =>
              ClaimTokenCubit(getIt<UnclaimedTokens>(), getIt<ClaimToken>())
                ..init(),
      child: const ClaimFundsScreen(),
    ),
  );
}
