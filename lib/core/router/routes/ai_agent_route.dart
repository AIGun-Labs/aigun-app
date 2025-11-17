part of 'app_routes.dart';

@TypedGoRoute<AiAgentRoute>(path: RoutePaths.aiAgent, name: RouteNames.aiAgent)
class AiAgentRoute extends GoRouteData {
  const AiAgentRoute();
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) => CupertinoPage(
      child: BlocProvider(
          create: (context) => getIt<AiAgentCubit>(),
          child: const AiAgentScreen()));
}
