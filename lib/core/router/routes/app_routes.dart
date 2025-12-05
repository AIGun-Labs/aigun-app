library;

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../features/home/presentation/pages/home.dart';
import '../../../screens/intel/intel.dart';
import '../../../screens/token_detail/token_detail.dart';
import '../../../themes/colors.dart';
import '../../../widgets/splash_screen.dart';
import '../../service_locator.dart';
import '../constants.dart';

part 'app_routes.g.dart';
part 'home_route.dart';
part 'splash_route.dart';
part 'token_detail_route.dart';

CustomTransitionPage<T> slideH<T>(
  Widget child, {
  required BuildContext context,
}) => CustomTransitionPage<T>(
  child: child,
  transitionsBuilder: (c, a, _, ch) {
    final t = Tween(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeInOut));

    final bg = AppColors.background(c);

    return SlideTransition(
      position: a.drive(t),
      child: Container(color: bg, child: ch),
    );
  },
);

CustomTransitionPage<T> fade<T>(Widget child) => CustomTransitionPage<T>(
  child: child,
  transitionsBuilder: (c, a, _, ch) => FadeTransition(opacity: a, child: ch),
);

CustomTransitionPage<T> slideV<T>(Widget child) => CustomTransitionPage<T>(
  child: child,
  transitionsBuilder: (c, a, _, ch) {
    final t = Tween(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeInOut));
    return SlideTransition(position: a.drive(t), child: ch);
  },
);

abstract class SlideHRouteData extends GoRouteData {
  const SlideHRouteData();

  Widget buildPageChild(BuildContext context, GoRouterState state);
  @override
  Page<void> buildPage(BuildContext c, GoRouterState s) =>
      slideH(buildPageChild(c, s), context: c);
}


// const SendConfirmAgainRoute().go(context);


// const SendConfirmAgainRoute().push(context);


// final result = await const SendConfirmAgainRoute().push<bool>(context);


// @TypedGoRoute<TokenDetailRoute>(
//   path: '/token/:id',
//   name: 'token-detail',
// )
// class TokenDetailRoute extends GoRouteData {
//   const TokenDetailRoute({required this.id});

//   final String id;

//   @override
//   Page<void> buildPage(BuildContext c, GoRouterState s) =>
//       slideH(TokenDetailScreen(id: id));
// }

// TokenDetailRoute(id: token.id).push(context);
