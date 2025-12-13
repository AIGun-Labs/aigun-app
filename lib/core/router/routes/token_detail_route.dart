part of 'app_routes.dart';

@TypedGoRoute<TokenDetailRoute>(
  path: RoutePaths.tokenDetail,
  name: RouteNames.tokenDetail,
)
class TokenDetailRoute extends GoRouteData with $TokenDetailRoute {
  const TokenDetailRoute(
    this.$extra, {
    this.type,
    this.tokenType,
    this.refreshKey,
  });

  final BaseTokenEntity $extra;

  final String? type;

  final String? tokenType;

  final String? refreshKey;

  @override
  Page<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) => CupertinoPage(
    child: MultiBlocProvider(
      key: ValueKey('${$extra.uniqueId}_${refreshKey ?? ''}'),
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<TokenInfoCubit>()..init(token: $extra, type: tokenType),
        ),
        BlocProvider(
          create: (context) =>
              getIt<IntelsCubit>()
                ..init(address: $extra.address, network: $extra.network),
        ),
        BlocProvider(
          create: (context) => getIt<TokenSecurityCubit>()
            ..getTokenSecurity(
              address: $extra.address,
              network: $extra.network,
            ),
        ),
        BlocProvider(
          create: (context) => getIt<HoldingsCubit>()
            ..startPolling(address: $extra.address, network: $extra.network),
        ),
        BlocProvider(
          create: (context) => getIt<CandleCubit>(
            param1: BlocProvider.of<TokenInfoCubit>(context),
          )..loadData(network: $extra.network, address: $extra.address),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CandlestickCubit>()
                ..updateToken(network: $extra.network, address: $extra.address),
        ),
      ],
      child: TokenDetailScreen(token: $extra, type: type, tokenType: tokenType),
    ),
  );
}
